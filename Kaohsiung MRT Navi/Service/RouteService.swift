//
//  StationService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/27.
//

import Foundation

class RouteService {
    
    static let shared = RouteService()
    
    private(set) var redLine: String = "{tuhCm_r}Uu@n@qAfAe@^uAjAuAjA_CtBiJjIYV[XuBtA]R_@Ra@Ru@^u@d@i@`@i@f@c@h@a@l@]n@Yp@M\\W~@S~@WpAS~@O`AE`@E^EbAAbA]n]ExEAl@Al@Ex@Gx@Kx@Mv@Ov@St@Wr@Wr@[p@]n@a@l@a@l@e@h@g@f@MLa@\\a@\\sMjKk@d@k@f@]\\Y`@c@n@a@n@sAzBc@p@c@n@k@t@o@p@k@f@m@d@sQtNoGbFmG`Fm@f@k@d@m@h@w@p@m@f@m@f@k@d@sVxRuLnJm@d@u@h@u@f@o@`@oAt@m@\\u@Xe@ZU`@}D|Cc@\\s@f@c@Z_Ap@k@^i@`@wHvF{B`Ba@X_@Xe@Vc@Vg@Rc@Pe@Pk@Re@Nc@Pg@Tg@Ve@XWP_@X_@XuAhAQLQNwHhGoA`AoA`AmPxL}C|Bo@b@m@`@o@\\q@Xu@Tu@RwTzFu@Rw@ReI|By[bJgA\\gAZaOxE_AX_ATk@Hk@Fm@Di@?cACaAEyCQaJi@w@Ew@Gu@Gu@GaBOw@Iy@Gy@Gw@Ey@Ey@Ey@EkFQ_[iAw@Ew@EqAGy@Ew@EyCKmHWaRq@e@Cg@AwAEk@Ai@Ca[iAuU{@[C[Au@As@?s@?s@@s@Bs@Dm@D[B[DcCTc@Bm@Fo@Dc@BcG\\mDRi@Bq@Dq@@s@@q@?q@Aq@Co@Ci@Ci@Ec@Cw@Ew@Cw@Au@Ac@?yA?u@?u@Ak@?oQQqQQo@Aq@Am@Ck@Ei@Gi@Ki@Km@Om@Si@QcO}Eu@Uo@Wo@Wm@Wm@Yq@_@_G_DeCsAg@Ym@]m@]m@a@k@_@k@a@i@c@k@c@i@c@g@e@i@g@e@e@_@_@}HgIg@i@i@g@k@a@e@[g@Ug@Sk@Oi@Km@Gk@Cm@?k@@m@Fk@Ji@Li@Rg@TWLm@b@k@d@g@d@oE~Di@f@k@d@[Xk@d@i@f@u@n@kLpKa@^i@b@k@b@i@b@k@`@m@^k@^g@Xe@VeLhGw@`@w@^aAZaAR_AH}@F_CNq@Fu@Ds@Ls@Nq@No@Re@Pg@Ni@Ns@Lw@Hi@@k@@}IHqZVm@@m@@w@@e@@g@?iHH_EDy@?y@Aq@Cq@Iw@Mw@QqP{De@Kc@Iq@Ms@Ie@Ee@Eq@Gi@Ek@Gk@Mk@Qk@Ug@Ye@]a@a@_@c@[g@Yk@O_@Qk@Mk@Me@Ok@Oi@}@eDuAeFUy@W{@Oe@W{@U{@yAmFQq@Uq@So@Wq@Oc@Sm@Ma@{H_WwBaHOc@Uq@Uo@Wo@Wm@Ui@_@o@_@m@c@k@e@i@g@g@i@c@k@a@m@_@o@[o@Ws@Uq@Qu@Os@Ku@Gu@Cu@Au@@u@Du@Fe@H{@N{Cl@}Cl@g@H{@Re@JaATe@J}@Re@JoXhFy@Pc@H{@PeMbCw@NqKx@y@?kO@wLBeIx@eKlE{GzCsClAaGjC_FxBgCdAwGvCwGvC}FtBaGhCwG~CwE~BeInDsEbBeJnCcF~BoEjBcI~BcAb@{FpB}PjE}PlEgJ|CyHbDaLhE"
    private(set) var orangeLine: String = "qkaiCa{a}UfCsFbGcMb@}@d@}@Vg@^u@Zu@Rm@Nm@Jq@Ho@Bs@@q@Cq@Eq@Iq@Mo@Qm@Um@Wi@[i@]e@a@a@c@_@e@[q@_@s@[aQwHqD_BaAc@_Ai@e@]c@a@_@e@[g@Wg@c@gA]iAmAeEQo@Qo@UgAOiAGs@Eq@ImAEs@Gq@My@My@Oo@Oo@_AwDOm@Oo@sC{LeCoKeCqKiBgHmBcKLqERsGRcEf@aQf@aQ\\eLRgFRiHTgHZuJ~@kTHoGAgH|@iKzAeKdCcItCyM`AcEzBqJvBaIvA_G~AiIpAsJk@}Jg@iIg@kIc@yGcAuNS_GKqJMgKPmMb@mDx@uJv@gGViAViALc@Lc@^eA`@cA`@}@b@{@tAoC\\q@Xu@Ni@Lk@Fm@Dm@?o@Cm@Gm@Ge@Sw@Ww@mG{RkTcq@Y}@U}@Ow@Iu@Cw@Aw@By@Fu@Lw@Nu@Pk@Xs@Xq@^o@^m@b@m@d@i@\\[\\]bEyDj@i@b@g@`@g@d@o@dEcGl@{@d@i@d@i@h@e@f@a@z@k@~DkC`C}A"
    private(set) var circleLine: String = "g~~hC}fl}U_AMe@IoCg@m@MeIiBwAW{AMyAE{A@yAJyAPwAZC@yHvBc@NiA^m@P{RtFKBm@NmAXq@PcD|@{_@vKI@IBE?I@E?EAE?EAEAECECGEgDoCgH_GQOSOIGGEIIIGg@_@uCcCMIOKQGOGSGkVeG[K_@K{ImCOEICE?KAKAM?K@K@OBuc@hLQDiB^cCZcCNcBDW@o@Dm@JA?k@Ni@Ri@Vg@Ze@\\a@b@_@d@KNm\\fh@ED}@`Bu@fBm@jBc@nB[rBEXCV}Eph@KlAEb@CRC`AA~@D~@H|@@LFb@xBbOf@jDf@lDpCfRJv@NjAF^F`@`AbG@LBP?H?J@FAN?L[jGCpAu@bg@ChLFlI@hCB~D@H?BHTHPDDBBBBD@B@F@D?J@|Wl@pLXzJT|AAv@DJ?pL\\|C@|CMxC[hB[zIiBTGPCZCPA~@CPAB?\\CLCTExPeDPE^GZCXCx@ET?\\?^@NB\\BJ@JBL@LDRHdAb@p@\\lI~E~BvA|D`CnEhCrKpGt@`@fAf@n@\\zD~BJFXNnCnAz@`@p@Vb@PbErA~@\\H@HBF?B?B?B?DAFCDABABCDEBEBIDKnEwMDI@G@G?E@IAEAGAECGCECCEEGEIEsB}@IECCCCCEEGAGCG?G?G?G@GBIBIhA{CL_@La@b@{AHWHW^eA|BkGpFiOJWDQDMDMBOBOBQBS@O?O@O?O?K?KAOAOAMAOCOAKEMCOEMEOEMEMIOIQIKGKKOMMIKIIKIKIKGWO{@g@GEECIIIIEGGKEKEICKCKaA}FG_@COAOCY?OAK?M?O?O@M?K@O@Q@KBKBOBOBKBKDODOBKDIFOFMDIDIHMHMDIFGJKNQJKHGFGLIPMRKTKTIXIb@MJCJCLALAJ?bA?H@D?J@H@JBHBbFzBb@PnAd@\\NbEfBTJJBLDNBNBLBP@N@L?P?N?LAPANCLCJCNENGNGJEHEFEJGHGFGFEHIHIFGDIHIFKFKFKBIFOHUrJgXFQDMBK@M@K@M?M?KAMAKCOCQYmAe@sBCMAI?G?I@G@GBEDGDGDCDCDALEpz@aVh@OfCo@bEkAh@O^Mp@U`@MlWmHRGJCLGJERIPMPKNONMNQLOLSJQJSHUFSFUFUBWDU@O?K@I?O?W?OAK?ICOCWAMCMI]CK}@yDKa@YsAOo@sAyFg@qBKa@eCmKKg@IYM_@Ka@KWKYO_@O]MWUc@MWOWOUOUGIQWQSQUQSY[sKeL_AaAoBwBe[k\\KMIGIIIGOIOIOISG}Cw@i@MsA]MCMEMEeA_@SIu@[QGEAwKcCSG]EmAMYCo@K"
    private(set) var routes: Route?
    
    private init() {
        loadFromFile()
    }
    
    private func loadFromFile() {
        guard let url = Bundle.main.url(forResource: "kmrt.json", withExtension: nil) else {
            debugPrint("Failed to locate file in bundle")
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            debugPrint("Failed to load file from bundle")
            return
        }
                
        do {
            let decoder = JSONDecoder()
            routes = try decoder.decode(Route.self, from: data)
    
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
}
