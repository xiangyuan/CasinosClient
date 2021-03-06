-- Copyright(c) Cragon. All rights reserved.

---------------------------------------
-- 配置，开发者选项
ConfigDevelopSettings = {
    ShowDevelopSettings = false; -- 是否显示开发者选项
    ClientShowFPS = false; -- 客户端显示FPS信息 false 不显示 true 显示
    FPSLimit = 60-- 限帧
}

function ConfigDevelopSettings:Load()
    local player_prefs = CS.UnityEngine.PlayerPrefs
    if (player_prefs.HasKey('ClientShowFPS') == true) then
        self.ClientShowFPS = player_prefs.GetString('ClientShowFPS')
    end
end

---------------------------------------
-- 配置，模块配置
ConfigModule = {
    --WalletEnable = false;-- 钱包模块
    GrowEnable = false; -- 摇钱树模块
}

function ConfigModule:Load()
end

---------------------------------------
-- 配置
Config = {
    CasinosContext = CS.Casinos.CasinosContext.Instance;
    LuaMgr = CS.Casinos.CasinosContext.Instance.LuaMgr;
    DevelopSettings = ConfigDevelopSettings;
    Module = ConfigModule;
    Env = nil;
    CommonVersion = nil;
    CommonRootURL = nil;
    DataVersion = nil;
    DataRootURL = nil;
    OssRootUrl = 'https://cragon-king-oss.cragon.cn';
    AutopatcherUrl = 'https://cragon-king-oss.cragon.cn/autopatcher/VersionInfo.xml';
    PlayerIconDomain = 'https://cragon-king-oss.cragon.cn/images/';
    BotIconDomain = 'https://cragon-king-oss.cragon.cn/ucenter/';
    SysNoticeInfoUrl = '';
    UCenterDomain = 'https://ucenter-dev.cragon.cn';
    GatewayIp = 'king-gateway-dev.cragon.cn';
    GatewayPort = 5882;
    BundleUpdateStata = 1;
    BundleUpdateVersion = '1.30.000';
    BundleUpdateUrlANDROID = 'https://cragon-king-oss.cragon.cn/ANDROID/KingTexas_1.30.000.apk';
    BundleUpdateUrlIOS = 'itms-services:///?action=download-manifest&url=https://cragon-king-oss.cragon.cn/KingTexas.plist';
    CommonFileListFileName = 'CommonFileList.txt';
    DataFileListFileName = 'DataFileList.txt';
    TbFileList = { 'KingCommon', 'KingDesktop', 'KingDesktopH', 'KingClient' };
    ServerState = 0; -- 服务器状态: 0正常,1维护
    ServerStateInfo = ''; -- 系统公告
    LotteryTicketFactoryName = 'Texas';
    ClientWechatIsInstalled = true;
    ClientShowWechat = true; -- 客户端显示微信登录按钮 false 不显示 true 显示
    ClientShowFirstRecharge = true; -- 客户端显示首充按钮 false 不显示 true 显示
    ClientShowGoldTree = false;
    NeedHideClientUi = false; -- 客户端排行等界面显示与隐藏
    DesktopHSysBankShowDBValue = true; -- 百人系统庄是否显示SQlite配置值
    ShootingTextShowVIPLimit = 0; -- 弹幕发送后是否真正发送弹幕VIP等级限制，0为无限制
    DesktopHCanChatVIPLimit = 1; -- 百人是否可聊天VIP等级限制，0为无限制
    DesktopCanChatVIPLimit = 0; -- 普通桌是否可聊天VIP等级限制，0为无限制
    CanReportLog = false; -- 是否开启上传日志到Bugly后台
    CanReportLogDeviceId = ""; -- 可以上传的机器码
    CanReportLogPlayerId = ""; -- 可以上传的玩家Id
    UseWechatPay = true;
    UseAliPay = true;
    UseIAP = false;
    UseLan = true;
    UseDefaultLan = false;
    DefaultLan = 'Chinese';
    ChipIconSolustion = 0;
    CurrentMoneyType = 0;
    UCenterAppId = 'King';
    PinggPPAppId = 'app_TCi58CGKCSaHGCuP';
    WeChatAppId = 'wxff929d92c3997b5d';
    WeChatAppSecret = '159e7a0f00dd15fd81fd63c4844b0dfc';
    WeChatState = 'Wechat';
    DataEyeId = 'E02253AEC6F95038833955AC4FED9D77';
    PushAppId = 'TXYr3LD0se8JU8UOtg9cj3';
    PushAppKey = 'F6i4mvPKr96KuYsNAXciw9';
    PushAppSecret = 'DWlJdILTq77OG68J4jFcx3';
    ShareSDKAppKey = '254dedc7a3730';
    ShareSDKAppSecret = '53788920e17ffa1d9af4ef3540352172';
    BeeCloudId = '9c24464e-c912-44aa-bfe8-ca3a384410d0';
    BeeCloudLiveSecret = '71625ddd-5a3d-4b73-be74-1580c8912dda';
    BeeCloudTestSecret = '7bbc79a8-f310-4d76-a582-2622242c23f5';
    PayUseTestMode = false;
    PayUrlScheme = "com.Cragon.KingTexas2";
}

function Config:Load()
    self.DevelopSettings:Load()
    self.Module:Load()
end

---------------------------------------
Context = {
    CasinosContext = CS.Casinos.CasinosContext.Instance;
    LuaMgr = CS.Casinos.CasinosContext.Instance.LuaMgr;
    Launch = Launch;
    PreViewMgr = PreViewMgr;
    LaunchStep = {};
    Cfg = Config;
    TbDataMgr = nil;
    Json = nil;
    Rpc = nil;
    LuaHelper = nil;
    ModelMgr = nil;
    ControllerMgr = nil;
    ViewMgr = nil;
}

---------------------------------------
function Context:Init()
    self.Cfg.Env = self.Launch.LaunchCfg.Env;
    self.Cfg.CommonVersion = self.Launch.LaunchCfg.CommonVersion;
    self.Cfg.CommonRootURL = string.format('https://cragon-king-oss.cragon.cn/Common/%s/', self.Launch.LaunchCfg.CommonVersion);
    self.Cfg.DataVersion = self.Launch.LaunchCfg.DataVersion;
    self.Cfg.DataRootURL = string.format('https://cragon-king-oss.cragon.cn/%s/Data_%s/', self.CasinosContext.Config.Platform, self.Launch.LaunchCfg.DataVersion);
    self.Cfg:Load()

    local show_fps_obj = self.CasinosContext.Config.GoMain:GetComponent("Casinos.MbShowFPS")
    show_fps_obj.enabled = self.Cfg.DevelopSettings.ClientShowFPS
    self:_initLaunchStep()
    self:_nextLaunchStep()
end

---------------------------------------
function Context:Release()
    if (self.TimerUpdateBundleApk ~= nil) then
        self.TimerUpdateBundleApk:Close()
        self.TimerUpdateBundleApk = nil
    end

    if (self.TimerUpdateCopyStreamingAssetsToPersistentData ~= nil) then
        self.TimerUpdateCopyStreamingAssetsToPersistentData:Close()
        self.TimerUpdateCopyStreamingAssetsToPersistentData = nil
    end

    if (self.TimerUpdateRemoteCommonToPersistent ~= nil) then
        self.TimerUpdateRemoteCommonToPersistent:Close()
        self.TimerUpdateRemoteCommonToPersistent = nil
    end

    if (self.TimerUpdateRemoteDataToPersistent ~= nil) then
        self.TimerUpdateRemoteDataToPersistent:Close()
        self.TimerUpdateRemoteDataToPersistent = nil
    end

    self.CasinosContext = nil
    self.LuaMgr = nil
    self.Launch = nil
end

---------------------------------------
function Context:DoString(name)
    self.LuaMgr:DoString(name)
end

---------------------------------------
function Context:OnSocketClose()
    if self.ControllerMgr == nil then
        return
    end
    self.ControllerMgr:DestroyPlayerControllers()
    local ctrl_login = self.ControllerMgr:GetController('Login')
    ctrl_login:_init(false)
    if (ctrl_login.ShowKickOutInfo) then
        ctrl_login.ShowKickOutInfo = false
        local info = self.LanMgr:getLanValue("AlreadyLogin")
        ViewHelper:UiShowInfoFailed(info)
    end
end

---------------------------------------
-- 初始化LaunchStep
function Context:_initLaunchStep()
    -- 检测Bundle是否需要更新
    if (self.Cfg.BundleUpdateStata == 1 and self.Cfg.BundleUpdateVersion ~= nil and self.CasinosContext.Config.VersionBundle ~= self.Cfg.BundleUpdateVersion) then
        self.LaunchStep[1] = "UpdateBundle"
    end

    -- 检测是否需要首次运行解压
    --local r = self.CasinosContext.Config:VersionCompare(self.CasinosContext.Config.VersionDataPersistent, self.CasinosContext.Config.StreamingAssetsInfo.DataVersion)
    --if (r < 0) then
    --    self.LaunchStep[2] = "CopyStreamingAssetsToPersistentData"
    --end

    -- 检测是否需要更新Common
    --if (self.CasinosContext.Config.VersionCommonPersistent ~= self.Cfg.CommonVersion) then
    self.LaunchStep[2] = "UpdateCommon"
    --end

    -- 检测是否需要更新Data
    --if (self.CasinosContext.Config.VersionDataPersistent ~= self.Cfg.DataVersion) then
    self.LaunchStep[3] = "UpdateData"
    --end

    -- 进入Login界面
    self.LaunchStep[4] = "ShowLogin"
end

---------------------------------------
-- 执行下一步LaunchStep
function Context:_nextLaunchStep()
    -- 更新Bundle
    if (self.LaunchStep[1] ~= nil) then
        self.Launch:UpdateViewLoadingDescAndProgress("准备更新安装包", 0, 100)
        if (self.CasinosContext.UnityAndroid == true) then
            -- 弹框让玩家选择，更新Bundle Apk
            local msg_info = string.format('有新的安装包需要更新\n当前BundleVersion：%s\n新的BundleVersion：%s',
                    self.CasinosContext.Config.VersionBundle, self.Cfg.BundleUpdateVersion)
            local view_premsgbox = self.PreViewMgr:CreateView("PreMsgBox")
            view_premsgbox:showMsgBox(msg_info,
                    function()
                        self.Launch:UpdateViewLoadingDescAndProgress("正在更新安装包", 0, 100)
                        self.WWWUpdateBundleApk = CS.UnityEngine.WWW(self.Cfg.BundleUpdateUrlANDROID)
                        self.TimerUpdateBundleApk = self.CasinosContext.TimerShaft:RegisterTimer(30, self, self._timerUpdateBundleApk)
                        self.PreViewMgr:DestroyView(view_premsgbox)
                    end,
                    function()
                        self.PreViewMgr:DestroyView(view_premsgbox)
                        CS.UnityEngine.Application.Quit()
                    end
            )
        elseif self.CasinosContext.UnityIOS == true then
            -- 弹框让玩家选择，更新Bundle Ipa
            local msg_info = string.format('有新的安装包需要更新\n当前BundleVersion：%s\n新的BundleVersion：%s',
                    self.CasinosContext.Config.VersionBundle, self.Cfg.BundleUpdateVersion)
            local view_premsgbox = self.PreViewMgr:CreateView("PreMsgBox")
            view_premsgbox:showMsgBox(msg_info,
                    function()
                        self.Launch:UpdateViewLoadingDescAndProgress("正在更新安装包", 0, 100)
                        -- TODO，调用打开ios下载链接api
                        CS.UnityEngine.Application.OpenURL(self.Cfg.BundleUpdateUrlIOS)
                        self.PreViewMgr:DestroyView(view_premsgbox)
                    end,
                    function()
                        self.PreViewMgr:DestroyView(view_premsgbox)
                        CS.UnityEngine.Application.Quit()
                    end
            )
        end
        return
    end

    -- 首次运行解压
    --if (self.LaunchStep[2] ~= nil) then
    --    self.Launch:UpdateViewLoadingDescAndProgress("首次运行解压资源，不消耗流量", 0, 100)
    --    if (self.CopyStreamingAssetsToPersistentData == nil) then
    --        self.CopyStreamingAssetsToPersistentData = CS.Casinos.CopyStreamingAssetsToPersistentData2()
    --        self.CopyStreamingAssetsToPersistentData:CopyAsync('')
    --    end
    --    self.TimerUpdateCopyStreamingAssetsToPersistentData = self.CasinosContext.TimerShaft:RegisterTimer(30, self, self._timerUpdateCopyStreamingAssetsToPersistentData)
    --    return
    --end

    -- 更新Common
    if (self.LaunchStep[2] ~= nil) then
        --if (CS.UnityEngine.Application.internetReachability == CS.UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork) then
        --end
        self.Launch:UpdateViewLoadingDescAndProgress("更新游戏脚本", 0, 100)
        local http_url = self.Cfg.CommonRootURL .. self.Cfg.CommonFileListFileName
        --print(http_url)
        local async_asset_loadgroup = CS.Casinos.CasinosContext.Instance.AsyncAssetLoadGroup
        async_asset_loadgroup:LoadWWWAsync(http_url,
                function(url, www)
                    -- 比较Oss上的CommonFileList.txt和Persistent中的CommonFileList.txt差异集，获取需要更新的列表
                    local commonfilelist_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath(self.Cfg.CommonFileListFileName)
                    --print(commonfilelist_persistent)
                    self.RemoteCommonFileListContent = www.text
                    local persistent_commonfilelist_content = self.LuaMgr:ReadAllText(commonfilelist_persistent)
                    local commonrootdir_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath('/')
                    self.UpdateRemoteCommonToPersistent = CS.Casinos.UpdateRemoteToPersistentData()
                    self.UpdateRemoteCommonToPersistent:UpateAsync(self.RemoteCommonFileListContent, persistent_commonfilelist_content, self.Cfg.CommonRootURL, commonrootdir_persistent)
                    self.TimerUpdateRemoteCommonToPersistent = self.CasinosContext.TimerShaft:RegisterTimer(30, self, self._timerUpdateRemoteCommonToPersistent)
                end
        )
        return
    end

    -- 更新Data
    if (self.LaunchStep[3] ~= nil) then
        --if (CS.UnityEngine.Application.internetReachability == CS.UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork) then
        --end
        self.Launch:UpdateViewLoadingDescAndProgress("更新游戏数据", 0, 100)
        local http_url = self.Cfg.DataRootURL .. self.Cfg.DataFileListFileName
        --print(http_url)
        local async_asset_loadgroup = CS.Casinos.CasinosContext.Instance.AsyncAssetLoadGroup
        async_asset_loadgroup:LoadWWWAsync(http_url,
                function(url, www)
                    -- 比较Oss上的datafilelist.txt和Persistent中的datafilelist.txt差异集，获取需要更新的Data列表
                    local datafilelist_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath(self.Cfg.DataFileListFileName)
                    --print(datafilelist_persistent)
                    self.RemoteDataFileListContent = www.text
                    local persistent_datafilelist_content = self.LuaMgr:ReadAllText(datafilelist_persistent)
                    local datarootdir_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath('/')
                    self.UpdateRemoteDataToPersistent = CS.Casinos.UpdateRemoteToPersistentData()
                    self.UpdateRemoteDataToPersistent:UpateAsync(self.RemoteDataFileListContent, persistent_datafilelist_content, self.Cfg.DataRootURL, datarootdir_persistent)
                    self.TimerUpdateRemoteDataToPersistent = self.CasinosContext.TimerShaft:RegisterTimer(30, self, self._timerUpdateRemoteDataToPersistent)
                end
        )
        return
    end

    -- 卸载Launch，加载并显示Login
    if (self.LaunchStep[4] ~= nil) then
        self.LaunchStep[4] = nil

        self.Launch:UpdateViewLoadingDescAndProgress("准备登录中", 0, 100)

        self.LuaMgr:LoadLuaFromRawDir(self.CasinosContext.PathMgr.DirLuaRoot)

        self.CasinosContext.CanReportLog = self.Cfg.CanReportLog
        self.CasinosContext.CanReportLogDeviceId = self.Cfg.CanReportLogDeviceId
        self.CasinosContext.CanReportLogPlayerId = self.Cfg.CanReportLogPlayerId
        if (self.CasinosContext.UnityAndroid == true) then
        end

        self:DoString("Class")
        self.MessagePack = require('MessagePack')
        self.MessagePack.set_string("binary")
        self.Json = require("json")
        self:DoString("Rpc")
        self.Rpc = Rpc
        self.Rpc:Setup()
        self:DoString("LuaHelper")
        self.LuaHelper = LuaHelper
        self:DoString("TexasHelper")
        self:DoString("TbDataMgr")

        self.TbDataMgr = TbDataMgr
        self.TbDataMgr:Setup()
        self:DoString("TbDataHelper")
        TbDataHelper:Setup(self.TbDataMgr)

        self:DoString("Item")
        self:DoString("ItemData1")
        self:DoString("Unit")
        self:DoString("UnitBilling")
        self:DoString("UnitConsume")
        self:DoString("UnitGiftNormal")
        self:DoString("UnitGiftTmp")
        self:DoString("UnitGoldPackage")
        self:DoString("UnitGoodsVoucher")
        self:DoString("UnitMagicExpression")
        self:DoString("UnitRedEnvelopes")

        self:DoString("LanMgr")
        self.LanMgr = LanMgr
        self.LanMgr:Setup()

        self:DoString("ModelMgr")
        self.ModelMgr = ModelMgr
        self.ModelMgr:Setup()
        self:_regModel()

        self:DoString("EventSys")
        self.EventSys = EventSys
        self.EventSys:Setup()

        self:DoString("UiChipShowHelper")
        self.UiChipShowHelper = UiChipShowHelper
        self.UiChipShowHelper:Setup()

        self:DoString("ViewMgr")
        self.ViewMgr = ViewMgr
        self.ViewMgr:Create()

        self:_regView()
        self:DoString("ViewHelper")
        ViewHelper:Setup()

        self:DoString("CasinoHelper")
        CasinoHelper:Setup(self.Rpc.MessagePack, self.LanMgr)
        self:DoString("Native")
        Native:Setup(self.ViewMgr, self)
        self:DoString("PicCapture")
        self.PicCapture = PicCapture:Setup(self.ViewMgr, self)

        self:DoString("ControllerMgr")
        self.ControllerMgr = ControllerMgr
        self.ControllerMgr:Create()

        self.CasinosContext.NetMgr:InitByLua()

        -- 销毁Launch相关资源，加载登录界面
        self:AddUiPackage('Common')
        self:AddUiPackage('LanZh')
        self:AddUiPackage('LanEn')
        self:AddUiPackage('LanZhAndroid')
        self.Launch:Finish()
        self.ControllerMgr:CreateController("UCenter", nil)
        self.ControllerMgr:CreateController("Login", nil)
    end
end

---------------------------------------
-- 定时器，更新BundleApk
function Context:_timerUpdateBundleApk(tm)
    local error_msg = self.WWWUpdateBundleApk.error
    if error_msg ~= nil then
        -- 下载失败
    end
    local is_done = self.WWWUpdateBundleApk.isDone
    if (is_done) then
        self.Launch:UpdateViewLoadingProgress(100, 100)
        self.TimerUpdateBundleApk:Close()
        self.TimerUpdateBundleApk = nil

        local apk_filename = self.CasinosContext.PathMgr:GetPersistentDataPath() .. '/KingTexas_' .. self.Cfg.BundleUpdateVersion .. '.apk'
        self.CasinosContext.LuaMgr:WriteFileFromWWW(apk_filename, self.WWWUpdateBundleApk)
        self.WWWUpdateBundleApk = nil
        if (self.CasinosContext.IsEditor == false) then
            CS.NativeFun.installAPK(apk_filename)
            CS.UnityEngine.Application.Quit()
        end

        -- 执行下一步LaunchStep
        self.LaunchStep[1] = nil
        self:_nextLaunchStep()
    else
        self.Launch:UpdateViewLoadingProgress(self.WWWUpdateBundleApk.progress * 100, 100)
    end
end

---------------------------------------
-- 定时器，首次运行解压
function Context:_timerUpdateCopyStreamingAssetsToPersistentData(tm)
    local is_done = self.CopyStreamingAssetsToPersistentData:IsDone()
    if (is_done) then
        self.TimerUpdateCopyStreamingAssetsToPersistentData:Close()
        self.TimerUpdateCopyStreamingAssetsToPersistentData = nil
        self.CopyStreamingAssetsToPersistentData = nil

        -- 用LaunchInfo.LaunchVersion覆盖Persistent中的；并更新VersionDataPersistent
        self.CasinosContext.Config:WriteVersionDataPersistent(self.CasinosContext.Config.LaunchInfo.LaunchVersion)

        -- 执行下一步LaunchStep
        self.LaunchStep[2] = nil
        self:_nextLaunchStep()
    else
        local value = self.CopyStreamingAssetsToPersistentData.LeftCount
        local max = self.CopyStreamingAssetsToPersistentData.TotalCount
        self.Launch:UpdateViewLoadingProgress(max - value, max)
    end
end

---------------------------------------
-- 定时器，更新Common
function Context:_timerUpdateRemoteCommonToPersistent(tm)
    local is_done = self.UpdateRemoteCommonToPersistent:IsDone()
    if (is_done) then
        self.TimerUpdateRemoteCommonToPersistent:Close()
        self.TimerUpdateRemoteCommonToPersistent = nil
        self.UpdateRemoteCommonToPersistent = nil

        -- 用Remote CommonFileList.txt覆盖Persistent中的；并更新VersionCommonPersistent
        local commonfilelist_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath(self.Cfg.CommonFileListFileName)
        CS.System.IO.File.WriteAllText(commonfilelist_persistent, self.RemoteCommonFileListContent)
        self.RemoteCommonFileListContent = nil
        self.CasinosContext.Config:WriteVersionCommonPersistent(self.Cfg.CommonVersion)

        -- 执行下一步LaunchStep
        self.LaunchStep[2] = nil
        self:_nextLaunchStep()
    else
        local value = self.UpdateRemoteCommonToPersistent.LeftCount
        local max = self.UpdateRemoteCommonToPersistent.TotalCount
        self.Launch:UpdateViewLoadingProgress(max - value, max)
    end
end

---------------------------------------
-- 定时器，更新Data
function Context:_timerUpdateRemoteDataToPersistent(tm)
    local is_done = self.UpdateRemoteDataToPersistent:IsDone()
    if (is_done) then
        self.TimerUpdateRemoteDataToPersistent:Close()
        self.TimerUpdateRemoteDataToPersistent = nil
        self.UpdateRemoteDataToPersistent = nil

        -- 用Remote DataFileList.txt覆盖Persistent中的；并更新VersionDataPersistent
        local datafilelist_persistent = self.CasinosContext.PathMgr:CombinePersistentDataPath(self.Cfg.DataFileListFileName)
        CS.System.IO.File.WriteAllText(datafilelist_persistent, self.RemoteDataFileListContent)
        self.RemoteDataFileListContent = nil
        self.CasinosContext.Config:WriteVersionDataPersistent(self.Cfg.DataVersion)

        -- 执行下一步LaunchStep
        self.LaunchStep[3] = nil
        self:_nextLaunchStep()
    else
        local value = self.UpdateRemoteDataToPersistent.LeftCount
        local max = self.UpdateRemoteDataToPersistent.TotalCount
        self.Launch:UpdateViewLoadingProgress(max - value, max)
    end
end

---------------------------------------
function Context:_regModel()
    self:DoString("ModelCommon")
    self:DoString("ModelAccount")
    self:DoString("ModelActor")
    self:DoString("ModelWallet")
    self:DoString("ModelUCenter")
    self:DoString("ModelTrade")
    self:DoString("ModelDesktop")
    self:DoString("ModelDesktopTexas")
    self:DoString("ModelDesktopTexasMatch")
    self:DoString("ModelActivity")
    self:DoString("ModelGrow")
    self:DoString("ModelPlayer")
    self:DoString("ModelRank")
    self:DoString("ModelMarquee")
    self:DoString("ModelWallet")
    self:DoString("ModelBag")
    self:DoString("ModelDesktopH")
    self:DoString("ModelIM")
    self:DoString("ModelIMClientEvent")
    self:DoString("ModelIMMailBox")
    self:DoString("ModelLotteryTicket")
    self:DoString("ModelPlayer")
    self:DoString("ModelPlayerInfo")
end

---------------------------------------
function Context:_regView()
    self:DoString("ViewAbout")
    self:DoString("ViewLoading")
    self:DoString("ViewLogin")
    self:DoString("UiResetPwd")
    self:DoString("UiRegister")
    self:DoString("UiChooseCountryCode")
    self:DoString("ViewMsgBox")
    local view_loading_fac = ViewLoadingFactory:new("Loading", "Loading", "Loading", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Loading", view_loading_fac)
    local view_msgbox_fac = ViewMsgBoxFactory:new("Common", "MsgBox", "Waiting", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MsgBox", view_msgbox_fac)
    local view_login_fac = ViewLoginFactory:new("Login", "Login", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Login", view_login_fac)
    local view_about_fac = ViewAboutFactory:new("About", "About", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("About", view_about_fac)
    self:DoString("ViewDesktopChatParent")
    local view_chatparent_fac = ViewDesktopChatParentFactory:new("DesktopChatParent", "DesktopChatParent", "DesktopChat", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopChatParent", view_chatparent_fac)
    self:DoString("ViewFloatMsg")
    local view_floatmsg_fac = ViewFloatMsgFactory:new("Common", "FloatMsg", "Waiting", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("FloatMsg", view_floatmsg_fac)
    self:DoString("ViewMailDetail")
    local view_maildetail_fac = ViewMailDetailFactory:new("MailDetail", "MailDetail", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MailDetail", view_maildetail_fac)
    self:DoString("ViewNotice")
    local view_notice_fac = ViewNoticeFactory:new("Notice", "Notice", "Loading", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Notice", view_notice_fac)
    self:DoString("ViewPayType")
    local view_paytype_fac = ViewPayTypeFactory:new("PayType", "PayType", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("PayType", view_paytype_fac)
    self:DoString("ViewPermanentPosMsg")
    local view_permanent_fac = ViewPermanentPosMsgFactory:new("Common", "PermanentPosMsg", "Loading", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("PermanentPosMsg", view_permanent_fac)
    self:DoString("ViewPool")
    local view_pool_fac = ViewPoolFactory:new("Pool", "Pool", "None", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Pool", view_pool_fac)
    self:DoString("ViewShootingText")
    local view_shooting_fac = ViewShootingTextFactory:new("ShootingText", "ShootingText", "ShootingText", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ShootingText", view_shooting_fac)
    self:DoString("ViewTakePhoto")
    local view_takephoto_fac = ViewTakePhotoFactory:new("TakePhoto", "TakePhoto", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("TakePhoto", view_takephoto_fac)
    self:DoString("ViewWaiting")
    local view_waiting_fac = ViewWaitingFactory:new("Common", "Waiting", "Waiting", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Waiting", view_waiting_fac)
    self:DoString("ViewWaitingCountDown")
    local view_waiting1_fac = ViewWaitingCountDownFactory:new("Common", "WaitingCountDown", "Waiting", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("WaitingCountDown", view_waiting1_fac)
    self:DoString("ViewLotteryTicket")
    self:DoString("ViewLotteryTicketRewardPot")
    local view_lottery_fac = ViewLotteryTicketFactory:new("LotteryTicket", "LotteryTicket", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("LotteryTicket", view_lottery_fac)
    self:DoString("ViewDesktopTexas")
    self:DoString("PlayerSeatWidgetControllerTexas")
    self:DoString("PlayerOperateAni")
    self:DoString("PlayerShowTips")
    self:DoString("ViewHandCardTexas")
    self:DoString("ViewPotTexasPoker")
    self:DoString("ViewDesktopTypeBase")
    self:DoString("ViewTexasClassic")
    self:DoString("ViewTexasMTT")
    self:DoString("DealerEx")
    self:DoString("ViewMTTGameResult")
    self:DoString("ItemMttRewardItem")
    local view_mttresult_fac = ViewMTTGameResultFactory:new("MTTGameResult", "MTTGameResult", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MTTGameResult", view_mttresult_fac)
    self:DoString("ViewMTTProcess")
    local view_mttprocess_fac = ViewMTTProcessFactory:new("MTTProcess", "MTTProcess", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MTTProcess", view_mttprocess_fac)
    self:DoString("UiCardCommonEx")
    self:DoString("UiCardDealingEx")
    self:DoString("UiChipEx")
    self:DoString("UiChipMgrEx")
    self:DoString("UiDesktopTexasFlow")
    self:DoString("ViewPlayerGiftAndVIP")
    self:DoString("DesktopPlayerTexas")
    self:DoString("DesktopBase")
    self:DoString("DesktopTexas")
    self:DoString("DesktopHelperBase")
    self:DoString("DesktopHelperTexas")
    self:DoString("DesktopTypeBase")
    self:DoString("DesktopTexasClassic")
    self:DoString("DesktopTexasMTT")
    local view_desktoptexas_fac = ViewDesktopTexasFactory:new("Desktop", "Desktop", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopTexas", view_desktoptexas_fac)
    self:DoString("ViewDesktopPlayerInfoTexas")
    local view_desktopplayerinfotexas_fac = ViewDesktopPlayerInfoTexasFactory:new("DesktopPlayerInfo", "DesktopPlayerInfo", "SceneActor", false, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopPlayerInfoTexas", view_desktopplayerinfotexas_fac)
    self:DoString("ViewDesktopPlayerOperateTexas")
    self:DoString("DesktopFastBet")
    local view_desktopoperatetexas_fac = ViewDesktopPlayerOperateTexasFactory:new("DesktopPlayerOperate", "DesktopPlayerOperate", "PlayerOperateUi", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopPlayerOperateTexas", view_desktopoperatetexas_fac)
    self:DoString("ViewLockChatTexas")
    local view_lockchattexas_fac = ViewLockChatTexasFactory:new("LockChat", "LockChat", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("LockChatTexas", view_lockchattexas_fac)
    self:DoString("ViewDesktopHintsTexas")
    local view_desktophintstexas_fac = ViewDesktopHintsTexasFactory:new("DesktopHints", "DesktopHints", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHintsTexas", view_desktophintstexas_fac)
    self:DoString("ViewDesktopMenuTexas")
    local view_desktopmenutexas_fac = ViewDesktopMenuTexasFactory:new("DesktopMenu", "DesktopMenu", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopMenuTexas", view_desktopmenutexas_fac)
    self:DoString("ViewDesktopChatExpression")
    local view_desktopchatexp_fac = ViewDesktopChatExpressionFactory:new("ChatExPression", "ChatExPression", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ChatExPression", view_desktopchatexp_fac)
    self:DoString("ViewDesktopH")
    self:DoString("ViewDesktopHBase")
    self:DoString("ViewDesktopHTexas")
    self:DoString("DesktopHBase")
    self:DoString("DesktopHTexas")
    self:DoString("GoldController")
    local view_desktoph_fac = ViewDesktopHFactory:new("DesktopH", "DesktopH", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopH", view_desktoph_fac)
    self:DoString("ViewDesktopHBankList")
    local view_desktophbanklist_fac = ViewDesktopHBankListFactory:new("DesktopHBankPlayerList", "DesktopHBankPlayerList", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHBankList", view_desktophbanklist_fac)
    self:DoString("ViewDesktopHBetReward")
    local view_desktophbetreward_fac = ViewDesktopHBetRewardFactory:new("DesktopHBetReward", "DesktopHBetReward", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHBetReward", view_desktophbetreward_fac)
    self:DoString("ViewDesktopHCardType")
    local view_desktophcardtype_fac = ViewDesktopHCardTypeFactory:new("DesktopHCardType", "DesktopHCardType", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHCardType", view_desktophcardtype_fac)
    self:DoString("ViewDesktopHHelp")
    local view_desktophhelp_fac = ViewDesktopHHelpFactory:new("DesktopHHelp", "DesktopHHelp", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHHelp", view_desktophhelp_fac)
    self:DoString("ViewDesktopHHistory")
    local view_desktophhistory_fac = ViewDesktopHHistoryFactory:new("DesktopHHistory", "DesktopHHistory", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHHistory", view_desktophhistory_fac)
    self:DoString("ViewDesktopHMenu")
    local view_desktophmenu_fac = ViewDesktopHMenuFactory:new("DesktopHMenu", "DesktopHMenu", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHMenu", view_desktophmenu_fac)
    self:DoString("ViewDesktopHResult")
    local view_desktophresult_fac = ViewDesktopHResultFactory:new("DesktopHResult", "DesktopHResult", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHResult", view_desktophresult_fac)
    self:DoString("ViewDesktopHSetCardType")
    local view_desktophsetcardtype_fac = ViewDesktopHSetCardTypeFactory:new("DesktopHSetCardType", "DesktopHSetCardType", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHSetCardType", view_desktophsetcardtype_fac)
    self:DoString("ViewDesktopHRewardPot")
    local view_desktophrewardpot_fac = ViewDesktopHRewardPotFactory:new("DesktopHRewardPot", "DesktopHRewardPot", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DesktopHRewardPot", view_desktophrewardpot_fac)
    self:DoString("ViewAgreeOrDisAddFriendRequest")
    local view_agreefriend_fac = ViewAgreeOrDisAddFriendRequestFactory:new("AgreeOrDisAddFriendRequest", "AgreeOrDisAddFriendRequest", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("AgreeOrDisAddFriendRequest", view_agreefriend_fac)
    self:DoString("ViewBag")
    local view_bag_fac = ViewBagFactory:new("Bag", "Bag", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Bag", view_bag_fac)
    self:DoString("ViewBank")
    local view_bank_fac = ViewBankFactory:new("Bank", "Bank", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Bank", view_bank_fac)
    self:DoString("ViewChat")
    local view_chat_fac = ViewChatFactory:new("Chat", "Chat", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Chat", view_chat_fac)
    self:DoString("ViewChatChooseTarget")
    local view_chatchoose_fac = ViewChatChooseTargetFactory:new("ChatChooseTarget", "ChatChooseTarget", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ChatChooseTarget", view_chatchoose_fac)
    self:DoString("ViewChatFriend")
    local view_chatfriend_fac = ViewChatFriendFactory:new("ChatFriend", "ChatFriend", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ChatFriend", view_chatfriend_fac)
    self:DoString("ViewChipOperate")
    local view_chipoperate_fac = ViewChipOperateFactory:new("ChipOperate", "ChipOperate", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ChipOperate", view_chipoperate_fac)
    self:DoString("ViewChooseLan")
    local view_chooselan_fac = ViewChooseLanFactory:new("ChooseLan", "ChooseLan", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ChooseLan", view_chooselan_fac)
    self:DoString("ViewShare")
    local view_share_fac = ViewShareFactory:new("Share", "Share", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Share", view_share_fac)
    self:DoString("ViewShareType")
    local view_sharetype_fac = ViewShareTypeFactory:new("ShareType", "ShareType", "NomalUi", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ShareType", view_sharetype_fac)
    self:DoString("ViewCreateDesktop")
    local view_createdesktop_fac = ViewCreateDesktopFactory:new("CreateDeskTop", "CreateDeskTop", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("CreateDeskTop", view_createdesktop_fac)
    self:DoString("ViewDailyReward")
    local view_dailyreward_fac = ViewDailyRewardFactory:new("DailyReward", "DailyReward", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("DailyReward", view_dailyreward_fac)
    self:DoString("ViewSettings")
    local view_settings_fac = ViewSettingsFactory:new("Settings", "Settings", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Settings", view_settings_fac)
    self:DoString("ViewFriend")
    local view_friend_fac = ViewFriendFactory:new("Friend", "Friend", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Friend", view_friend_fac)
    self:DoString("ViewFriendOnLine")
    local view_friendonline_fac = ViewFriendOnLineFactory:new("FriendOnLine", "FriendOnLine", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("FriendOnLine", view_friendonline_fac)
    self:DoString("ViewGiftDetail")
    local view_giftdetail_fac = ViewGiftDetailFactory:new("GiftDetail", "GiftDetail", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("GiftDetail", view_giftdetail_fac)
    self:DoString("ViewGiftShop")
    local view_giftshop_fac = ViewGiftShopFactory:new("GiftShop", "GiftShop", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("GiftShop", view_giftshop_fac)
    self:DoString("ViewGoldTree")
    local view_goldtree_fac = ViewGoldTreeFactory:new("GoldTree", "GoldTree", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("GoldTree", view_goldtree_fac)
    self:DoString("ViewInviteFriendPlay")
    local view_invite_fac = ViewInviteFriendPlayFactory:new("InviteFriendPlay", "InviteFriendPlay", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("InviteFriendPlay", view_invite_fac)
    self:DoString("ViewIdCardCheck")
    local id_check_fac = ViewIdCardCheckFactory:new("IdCardCheck", "IdCardCheck", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("IdCardCheck", id_check_fac)
    self:DoString("ViewLobby")
    local view_classicmodel_fac = ViewLobbyFactory:new("ClassicModel", "ClassicModel", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ClassicModel", view_classicmodel_fac)
    self:DoString("ViewMail")
    local view_viewmail_fac = ViewMailFactory:new("Mail", "Mail", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Mail", view_viewmail_fac)
    self:DoString("ViewMain")
    self:DoString("ViewReward")
    local view_reward_fac = ViewRewardFactory:new("Reward", "Reward", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Reward", view_reward_fac)
    self:DoString("UiMainPlayerInfo")
    local view_viewmain_fac = ViewMainFactory:new("Main", "Main", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Main", view_viewmain_fac)
    self:DoString("ViewFeedback")
    local view_viewfeedback_fac = ViewFeedbackFactory:new("Feedback", "Feedback", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Feedback", view_viewfeedback_fac)
    self:DoString("ViewPlayerInfo")
    local view_playerinfo_fac = ViewPlayerInfoFactory:new("PlayerInfo", "PlayerInfo", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("PlayerInfo", view_playerinfo_fac)
    self:DoString("ViewPlayerProfile")
    local view_playerprofile_fac = ViewPlayerProfileFactory:new("PlayerProfile", "PlayerProfile", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("PlayerProfile", view_playerprofile_fac)
    self:DoString("ViewActivityCenter")
    local view_activitycenter_fac = ViewActivityCenterFactory:new("ActivityCenter", "ActivityCenter", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ActivityCenter", view_activitycenter_fac)
    self:DoString("ViewQuitOrBack")
    local view_back_fac = ViewQuitOrBackFactory:new("QuitOrBack", "QuitOrBack", "QuitGame", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("QuitOrBack", view_back_fac)
    self:DoString("ViewRanking")
    local view_ranking_fac = ViewRankingFactory:new("Ranking", "Ranking", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Ranking", view_ranking_fac)
    self:DoString("ViewRechargeFirst")
    local view_recharge_fac = ViewRechargeFirstFactory:new("RechargeFirst", "RechargeFirst", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("RechargeFirst", view_recharge_fac)
    self:DoString("ViewResetPwd")
    local view_resetpwd_fac = ViewResetPwdFactory:new("ResetPwd", "ResetPwd", "NomalUi", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ResetPwd", view_resetpwd_fac)
    self:DoString("ViewShop")
    local view_shop_fac = ViewShopFactory:new("Shop", "Shop", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Shop", view_shop_fac)
    self:DoString("ViewWallet")
    local view_wallet_fac = ViewWalletFactory:new("Wallet", "Wallet", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Wallet", view_wallet_fac)
    self:DoString("ViewHeadIcon")
    self:DoString("ViewVIPSign")
    self:DoString("ViewHeadIconBig")
    local view_headionbig_fac = ViewHeadIconBigFactory:new("Common", "CoHeadIconBig", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("HeadIconBig", view_headionbig_fac)
    self:DoString("ViewActivityPopup")
    local view_activity_popup_fac = ViewActivityPopupFactory:new("ActivityPopup", "ActivityPopup", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ActivityPopup", view_activity_popup_fac)
    self:DoString("ViewMatchLobby")
    local view_matchlobby_fac = ViewMatchLobbyFactory:new("MatchLobby", "MatchLobby", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MatchLobby", view_matchlobby_fac)
    self:DoString("ViewApplySucceed")
    local view_applysucceed_fac = ViewApplySucceedFactory:new("ApplySucceed", "ApplySucceed", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ApplySucceed", view_applysucceed_fac)
    self:DoString("ViewMatchInfo")
    local view_matchinfo_fac = ViewMatchInfoFactory:new("MatchInfo", "MatchInfo", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("MatchInfo", view_matchinfo_fac)
    self:DoString("ViewClub")
    local view_club_fac = ViewClubFactory:new("Club", "Club", "Background", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("Club", view_club_fac)
    self:DoString("ViewCreateMatch")
    local view_creatematch = ViewCreateMatchFactory:new("CreateMatch", "CreateMatch", "NomalUiMain", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("CreateMatch", view_creatematch)
    self:DoString("ViewBlindTable")
    local view_blindtable = ViewBlindTableFactory:new("BlindTable", "BlindTable", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("BlindTable", view_blindtable)
    self:DoString("ViewClubHelp")
    local view_clubhelp = ViewClubHelpFactory:new("ClubHelp", "ClubHelp", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("ClubHelp", view_clubhelp)
    self:DoString("ViewJoinMatch")
    local view_joinmatch = ViewJoinMatchFactory:new("JoinMatch", "JoinMatch", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("JoinMatch", view_joinmatch)
    self:DoString("ViewGetChipEffect")
    local view_getchipeffect = ViewGetChipEffectFactory:new("GetChipEffect", "GetChipEffect", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("GetChipEffect", view_getchipeffect)
    self:DoString("ViewEnterMatchNotify")
    local view_enterMatchNotify = ViewEnterMatchNotifyFactory:new("EnterMatchNotify", "EnterMatchNotify", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("EnterMatchNotify", view_enterMatchNotify)
    self:DoString("ViewSnowBallReward")
    local view_snowBallRewardFactory = ViewSnowBallRewardFactory:new("SnowBallReward", "SnowBallReward", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("SnowBallReward", view_snowBallRewardFactory)
    self:DoString("ViewEditAddress")
    local view_editAddressFactory = ViewEditAddressFactory:new("EditAddress", "EditAddress", "MessgeBox", true, CS.FairyGUI.FitScreen.FitSize)
    self.ViewMgr:RegView("EditAddress", view_editAddressFactory)
    --Item
    self:DoString("ItemAttachment")
    self:DoString("ItemBetChipRange")
    self:DoString("ItemChatEx")
    self:DoString("ItemChatPresetMsg")
    self:DoString("ItemDailyReward")
    self:DoString("ItemDesktopHintsInfo")
    self:DoString("ItemDesktopRaiseOperateGFlower")
    self:DoString("ItemHeadIcon")
    self:DoString("ItemHeadIconWithNickName")
    self:DoString("ItemMagicExpIcon")
    self:DoString("ItemMagicExpSender")
    self:DoString("ItemMail")
    self:DoString("ItemNotice")
    self:DoString("ItemNumOperate")
    self:DoString("ItemPlayerChatLock")
    self:DoString("ItemPlayerReport")
    self:DoString("ItemChatDesktop")
    self:DoString("ItemCountryCode")
    self:DoString("ItemChatTargetInfo")
    self:DoString("ItemChooseChatTargetInfo")
    self:DoString("ItemDesktopHRewardPotPlayerInfo")
    self:DoString("ItemAnte")
    self:DoString("ItemGift")
    self:DoString("ItemGiftType")
    self:DoString("ItemInviteFriendPlay")
    self:DoString("ItemLan")
    self:DoString("ItemLobbyDesk")
    self:DoString("ItemLobbyDeskPlayInfo")
    self:DoString("ItemMainOperate")
    self:DoString("ItemRank")
    self:DoString("ItemReportPlayerOperate")
    self:DoString("ItemShowFriendSimple")
    self:DoString("ItemUiShopConsume")
    self:DoString("ItemUiShopDiamond")
    self:DoString("ItemUiShopGold")
    self:DoString("ItemUiShopVIPInfo")
    self:DoString("ItemUiShopVIPInfo")
    self:DoString("ItemVIPBuyInfo")
    self:DoString("ItemActivity")
    self:DoString("ItemActivityTitle")
    self:DoString("ItemUiShopGoods")
    self:DoString("ItemUiPurseGold")
    self:DoString("ItemMatchType")
    self:DoString("ItemMatchInfo")
    self:DoString("ItemBlind")
    self:DoString("ItemMatchInfoBlind")
    self:DoString("ItemMatchInfoReward")
    self:DoString("ItemSnowBallRewardPlayerNum")
    self:DoString("ItemSnowBallRewardInfo")
    self:DoString("ItemMatchInfoRank")
end

---------------------------------------
-- 计算BotIcon Url
function Context:CalcBotIconUrl(is_small, icon)
    if (is_small == true) then
        return self.Cfg.BotIconDomain .. 'boticonsmall/' .. icon .. '.jpg'
    else
        return self.Cfg.BotIconDomain .. 'boticon/' .. icon .. '.jpg'
    end
end

---------------------------------------
-- FairyGUI.AddPackage
function Context:AddUiPackage(ab_name)
    local ab = self.ModelMgr:QueryAssetBundle(ab_name)
    if ab == nil then
        local path_ab = self.CasinosContext.PathMgr.DirAbUi .. string.lower(ab_name) .. ".ab"
        ab = CS.UnityEngine.AssetBundle.LoadFromFile(path_ab)
        CS.FairyGUI.UIPackage.AddPackage(ab)
        self.ModelMgr:AddAssetBundle(ab_name, ab)
    end
end