Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798543497BC
	for <lists+linux-efi@lfdr.de>; Thu, 25 Mar 2021 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCYRTu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 13:19:50 -0400
Received: from mail-dm6nam10on2101.outbound.protection.outlook.com ([40.107.93.101]:22752
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhCYRTm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNwgZt3eLhZHJFz8Na93pc1g0xd7EMUHQv3srKL/G8OW8PPdNoHKr73OAtzzmeKMqcL67cxo4K3XyR0zNI/hZj1tKT7fYRCQc6JD/dBLWL2G7zdUlDH/UzlEQOzGRAJBdT1XqwWPBAUDlffQNbAbCOepmQGNlRyekjwmtOLSmY+2UrLXq/vxB5IpIJ/AOGC6saHnUVaDpDVC7QPYMQUqR++HXl6pL6dwRsKM2MhVYHW5I1vvKfLl8oSM0XzEi/UUb8eokYX7ATmqjRfBnnshbesmexAMoswRWhvfHQYw9Nz7LZp8YE9N/xMHiKoj9UOWrF9wL9PpYQ+Nfay9SV0TXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTEVlwBvMh0VFAOoz5vmQwBpkqNOf1j1cp2nGXtMoM0=;
 b=ehoKeBMvZbsZ9AXfunf2yW/ZdPtYSzFvxQ79wMmdRIwwAUakcGu6QPoaBPC8k8OPTr0uJ1mNWB/nKCU1MyQpHVvnUze2tCTdAVE7iPrfkojUimcczp/xGm281HfR1A2MKji5fgURAv518iO/q3u0Bah+k3i436TMIsf3V/d9j7ccqyNb/7H/PHHRM8TMqJ0OG2blxYI5KjQ6NXk6vYkjDis308B58l3VTuPgxxQgf/N5TuCMcT0JCCg3QriMktowYOGSSUibsNzWi0YGkmBHa0s8Jh4xwYOt8n+gGumuD1zTkMWIDkiikzVD1oIMSP0XhGh2AhTV19xR8kvDy8YsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTEVlwBvMh0VFAOoz5vmQwBpkqNOf1j1cp2nGXtMoM0=;
 b=jsHAlDkq0fbbnWWucDwF8KX1kHBOkkPxGZqlhu743HXwbIhpqJjcVHa+53X3/nKR1Jn4u37I1X3xLCF2T4PGP00sYGoSCPGX0MD/hfBMcWFPdOzcGTRGwlKd7OsDDmxcs04gitREr/MlDsaHsHVISwy/8znVZ+bbV4ifaU4p+6w=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0907.namprd21.prod.outlook.com (2603:10b6:302:10::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.6; Thu, 25 Mar
 2021 17:19:40 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3999.017; Thu, 25 Mar 2021
 17:19:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Mark Rutland <Mark.Rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Thread-Topic: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Thread-Index: AQHXFFVaurdvub5JekCZY4ghSD5HLqqTdEaAgADFzNCAAFeAAIAAeiPA
Date:   Thu, 25 Mar 2021 17:19:39 +0000
Message-ID: <MWHPR21MB15933E2184EFCB3F967BE397D7629@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
 <20210324165519.GA24528@C02TD0UTHF1T.local>
 <MWHPR21MB159351AFC4226A6AA8E33530D7629@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210325095626.GA36570@C02TD0UTHF1T.local>
In-Reply-To: <20210325095626.GA36570@C02TD0UTHF1T.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-25T17:19:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56b0f78a-8469-433f-8b11-7c1f0448d7c4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71558276-0227-4c45-2687-08d8efb22c51
x-ms-traffictypediagnostic: MW2PR2101MB0907:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0907F4CB0A448061C59D9B53D7629@MW2PR2101MB0907.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Z3DmZPy+l1XuDSX6LwOi3fb0gyuVzmn9CLPpGpqavRCXgeFIbpFjfTNFtKpA7gy4odVnesmcCAlb+4aBVBycfn0RI301Q9kUgqJ1sCg/BPAM9LuOXSLtVqrYm4ypXWSGL3hAs6RNBMsfqEsxjO2szqwBOhjSledw3I3nKnRi/5fZ85HxQhFRga7ohTNaJvILTYtpnSQUREiFxM2eiSYG/gdrQV4fa7ZBR233Ra9GwHSlF5epPZANygAuvnSM/EKMUSymEDmjkhNbz4MedqG2uMWBo97HqLcdP2loWmr9ilq89Nag5a5XCUSQZHvq3UilQrmiWWQHU7fiKfebcGcKmvgpT/pjf8+aho65LEkJYCQSSVYsUmlHaNC3v2fF8Qz0no7319SG6E9o8ZxNK1JILL+9VokxbivEYpJ1/NDP+KpPeoh3zbFNsaWq5QFJ6R+229fVEc542osWIgPvL854IWAJVcRMOsaSCf5OVDlkx1+wljW8vX9ZJhEcTBHOpJ4HXFIeU1h3d3LSIxkO2vK2dx5/VT6SCAxsDxGAcMhA8ZdxF09GFjJS7LtGSNoa4lbhouvWOaJ3CN8nq+qp2zuIXt7kEVxbLUuvmGPdDWgHviFXZJ0lkTB0/IqJKWFmWVOTFNqI/Nlo7lr4tZj1965yozGa+wxe6suZhN2I6Jd6Yc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(55016002)(82950400001)(66556008)(10290500003)(64756008)(82960400001)(66446008)(316002)(4326008)(66946007)(52536014)(66476007)(76116006)(38100700001)(8990500004)(7696005)(71200400001)(110136005)(9686003)(83380400001)(8676002)(8936002)(33656002)(107886003)(478600001)(7416002)(5660300002)(54906003)(186003)(2906002)(26005)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1yqQXv5cqETY/SJWnKW0EHp5cvZeQMGTFjRd6/fEAB/5sjPzDVFDF5slDO+o?=
 =?us-ascii?Q?A5z6yzzY4px+bDQTzVryoCmH9lRRV0VhBMGCyT7LWu773Oo47MP5/x9Q2i7Z?=
 =?us-ascii?Q?6YyfI75QAZIc+VfxHRZls+rT883alFHSBUtVb5WrA8/GrjkXoAZdmRo5b0N1?=
 =?us-ascii?Q?hcUhXWO5kSTJzJNsUrJkOQs7ANTnpLoew1pNFsm1Xd40BtYP40LpLMMpdo3q?=
 =?us-ascii?Q?ynwhYOYl0MP5mT55zGOxeTAk0mFad2JaEkqmSlQViAgh2U+K0WO6iJGTpyLi?=
 =?us-ascii?Q?rlDCrXSE/bYJIy3kki+Ov2gXlWY2Re1aaeiz+EdMaTepJfnZnKXXFYKV5JuB?=
 =?us-ascii?Q?y5SHQfc0m4Qv4BjViE3nSHC4AlfKraf3/NaRGme1IUIaBEFvzz7yUQYhoz/e?=
 =?us-ascii?Q?88OO9TV+wv6393h6S09ZWAxCucM2nzI5lZoGyK4O1yB4MSRl1+jwgfpwPqXj?=
 =?us-ascii?Q?U+wQwdkc79XYD/q/1lecFSfiO/9wqn8miydywLh7YNCTlgXxhYdlJXpdUHmu?=
 =?us-ascii?Q?tMZ6nEwVJQNhdmwwvBzo1hdwVQJVdt+t/i1AJXaKgFrOO5zozbZpR6dvRNSC?=
 =?us-ascii?Q?wZ9D/NxLuccf9yczJD8t5HAJoMVisCVgck/QgI4JLVZ7HxN75eO7kLBKpNWU?=
 =?us-ascii?Q?KxIyVCM+OoGN4fbo7xTYgMT4k3k0gREv7SsW8tvuZT8Bq36n1ph/t980KZ6p?=
 =?us-ascii?Q?DdPOsxYZebNjKiLM5A317i6KKgOztAK9Cd8seplyrzJJIz43kJLmhBiDVK2R?=
 =?us-ascii?Q?r2pu8OhWOOhoXaurQl0SIeNCqYxcrx7ZUB3dG4/qJhIKeALEZU5kZE1sVsCl?=
 =?us-ascii?Q?xqxOrOc243zhygk3k2+uWPHqwE58bvkkgqyESVhzKpJiT8Mdh6iMKZR6H3mG?=
 =?us-ascii?Q?trOgk8vH5wcH4A6LC0LnO2Xl1pyfB29w1NXUMqk2g6hqj9X2ySjoHmHZ+rSn?=
 =?us-ascii?Q?4C8uvmkT+L5msU39pBVWxDvg4TpDE20lRBfHDCR6zyB3o7StjOcHnsqZccuJ?=
 =?us-ascii?Q?TDLas/qGgkNn0NCq7GgRL0rN0JfgzgF5sIR6ZZuCtlN51z1SgzqYqpGjrehg?=
 =?us-ascii?Q?DSjWoBMxy4eXYKAi/EiG1n4la5JCe74LFN20Li76eLloIilg4rFGbCsWq81l?=
 =?us-ascii?Q?NcTGlIO6Ns3VvkHEy0ssDGF8ie6+mpN20t+DmUfBaEK+DEddFOoeTenlLSll?=
 =?us-ascii?Q?DZPDF8EzdMGFyMFr+rmEmM0DxS6n+L7m+6VaPORq9acVROps9MmT7KqiI2Rb?=
 =?us-ascii?Q?b/TIGWto1t6RMV3vFX0COib8yohIbY2LCNjKQI4a1QisvkBWEX5mOzhdzlcZ?=
 =?us-ascii?Q?Uaprkb8SVzsBD969Xnd1haSS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71558276-0227-4c45-2687-08d8efb22c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:19:39.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hflwrrFN62knJOCljuUq1D5R9fZ6p5cAU36F+dYjt/vvbg4qd+HixA3OVRzZxSAdm+FcDeGHtq9emeqLyv4/8SmBkdXzlMQKn8kUrhChUz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0907
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Thursday, March 25, 2021 2:=
56 AM
>=20
> On Thu, Mar 25, 2021 at 04:55:51AM +0000, Michael Kelley wrote:
> > From: Mark Rutland <mark.rutland@arm.com> Sent: Wednesday, March 24, 20=
21 9:55 AM
> > > For the benefit of others here, SMCCCv1.2 allows:
> > >
> > > * SMC64/HVC64 to use all of x1-x17 for both parameters and return val=
ues
> > > * SMC32/HVC32 to use all of r1-r7 for both parameters and return valu=
es
> > >
> > > The rationale for this was to make it possible to pass a large number=
 of
> > > arguments in one call without the hypervisor/firmware needing to acce=
ss
> > > the memory of the caller.
> > >
> > > My preference would be to add arm_smccc_1_2_{hvc,smc}() assembly
> > > functions which read all the permitted argument registers from a stru=
ct,
> > > and write all the permitted result registers to a struct, leaving it =
to
> > > callers to set those up and decompose them.
> > >
> > > That way we only have to write one implementation that all callers ca=
n
> > > use, which'll be far easier to maintain. I suspect that in general th=
e
> > > cost of temporarily bouncing the values through memory will be domina=
ted
> > > by whatever the hypervisor/firmware is going to do, and if it's not w=
e
> > > can optimize that away in future.
> >
> > Thanks for the feedback, and I'm working on implementing this approach.
> > But I've hit a snag in that gcc limits the "asm" statement to 30 argume=
nts,
> > which gives us 15 registers as parameters and 15 registers as return
> > values, instead of the 18 each allowed by SMCCC v1.2.  I will continue
> > with the 15 register limit for now, unless someone knows a way to excee=
d
> > that.  The alternative would be to go to pure assembly language.
>=20
> I realise in retrospect this is not clear, but when I said "assembly
> functions" I had meant raw assembly functions rather than inline
> assembly.
>=20
> We already have __arm_smccc_smc and __arm_smccc_hvc assembly functions
> in arch/{arm,arm64}/kernel/smccc-call.S, and I'd expected we'd add the
> full fat SMCCCv1.2 variants there.
>=20

FWIW, here's an inline assembly version that I have working.  On the plus
side, gcc does a decent job of optimizing.  It doesn't store to memory any
result registers that aren't consumed by the caller.  On the downside, it's
limited to 15 args and 15 results as noted previously.  So it doesn't meet
your goal of fully implementing the v1.2 spec.  Also, all 15 input argument=
s
must be initialized or gcc complains about using uninitialized values.

This version should handle both the 32-bit and 64-bit worlds, though I've
only tested in the 64-bit world.

I've made the input and output structures be arrays rather than listing
each register as a separate field.  Either approach should work, and I'm no=
t
sure what the tradeoffs are.

But if building on what Sudeep Holla has already done with raw assembly
is preferred, I'm OK with that as well.

Michael

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index acda958..e98cf07 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -408,5 +408,112 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, uns=
igned long a1,
 		method;							\
 	})
=20
+
+#ifdef CONFIG_ARM64
+#define SMCCC_1_2_REG_COUNT	18
+
+#define ARM64_ADDITIONAL_RESULT_DECLARATIONS				\
+		register unsigned long r8 asm("r8");			\
+		register unsigned long r9 asm("r9");			\
+		register unsigned long r10 asm("r10");			\
+		register unsigned long r11 asm("r11");			\
+		register unsigned long r12 asm("r12");			\
+		register unsigned long r13 asm("r13");			\
+		register unsigned long r14 asm("r14");
+
+#define ARM64_ADDITIONAL_ARG_DECLARATIONS				\
+		register unsigned long arg8 asm("r8") =3D __a->reg[8];	\
+		register unsigned long arg9 asm("r9") =3D __a->reg[9];	\
+		register unsigned long arg10 asm("r10") =3D __a->reg[10];	\
+		register unsigned long arg11 asm("r11") =3D __a->reg[11];	\
+		register unsigned long arg12 asm("r12") =3D __a->reg[12];	\
+		register unsigned long arg13 asm("r13") =3D __a->reg[13];	\
+		register unsigned long arg14 asm("r14") =3D __a->reg[14];
+
+#define ARM64_ADDITIONAL_OUTPUT_REGS					\
+			, "=3Dr" (r8), "=3Dr" (r9), "=3Dr" (r10), "=3Dr" (r11),	\
+			"=3Dr" (r12), "=3Dr" (r13), "=3Dr" (r14)
+
+#define ARM64_ADDITIONAL_INPUT_REGS					\
+			, "r" (arg8), "r" (arg9), "r" (arg10),		\
+			"r" (arg11), "r" (arg12), "r" (arg13),		\
+			"r" (arg14)
+
+#define ARM64_ADDITIONAL_RESULTS					\
+			__r->reg[8] =3D r8;				\
+			__r->reg[9] =3D r9;				\
+			__r->reg[10] =3D r10;				\
+			__r->reg[11] =3D r11;				\
+			__r->reg[12] =3D r12;				\
+			__r->reg[13] =3D r13;				\
+			__r->reg[14] =3D r14;
+
+#else /* CONFIG_ARM64 */
+
+#define SMCCC_1_2_REG_COUNT	8
+#define ARM64_ADDITIONAL_RESULT_DECLARATIONS
+#define ARM64_ADDITIONAL_ARG_DECLARATIONS
+#define ARM64_ADDITIONAL_OUTPUT_REGS
+#define ARM64_ADDITIONAL_INPUT_REGS
+#define ARM64_ADDITIONAL_RESULTS
+
+#endif /* CONFIG_ARM64 */
+
+struct arm_smccc_1_2_regs {
+	unsigned long reg[SMCCC_1_2_REG_COUNT];
+};
+
+
+#define __arm_smccc_1_2(inst, args, res)				\
+	do {								\
+		struct arm_smccc_1_2_regs * __a =3D args;			\
+		struct arm_smccc_1_2_regs * __r =3D res;			\
+		register unsigned long r0 asm("r0");			\
+		register unsigned long r1 asm("r1");			\
+		register unsigned long r2 asm("r2");			\
+		register unsigned long r3 asm("r3");			\
+		register unsigned long r4 asm("r4");			\
+		register unsigned long r5 asm("r5");			\
+		register unsigned long r6 asm("r6");			\
+		register unsigned long r7 asm("r7");			\
+		ARM64_ADDITIONAL_RESULT_DECLARATIONS			\
+		register unsigned long arg0 asm("r0") =3D (u32)(__a->reg[0]); \
+		register unsigned long arg1 asm("r1") =3D __a->reg[1];	\
+		register unsigned long arg2 asm("r2") =3D __a->reg[2];	\
+		register unsigned long arg3 asm("r3") =3D __a->reg[3];	\
+		register unsigned long arg4 asm("r4") =3D __a->reg[4];	\
+		register unsigned long arg5 asm("r5") =3D __a->reg[5];	\
+		register unsigned long arg6 asm("r6") =3D __a->reg[6];	\
+		register unsigned long arg7 asm("r7") =3D __a->reg[7];	\
+		ARM64_ADDITIONAL_ARG_DECLARATIONS			\
+		asm volatile(inst "\n" :				\
+			"=3Dr" (r0), "=3Dr" (r1), "=3Dr" (r2), "=3Dr" (r3),	\
+			"=3Dr" (r4), "=3Dr" (r5), "=3Dr" (r6), "=3Dr" (r7)	\
+			ARM64_ADDITIONAL_OUTPUT_REGS :			\
+			"r" (arg0), "r" (arg1), "r" (arg2),		\
+			"r" (arg3), "r" (arg4), "r" (arg5),		\
+			"r" (arg6), "r" (arg7)				\
+			ARM64_ADDITIONAL_INPUT_REGS :			\
+			"memory");					\
+		if(__r) {						\
+			__r->reg[0] =3D r0;				\
+			__r->reg[1] =3D r1;				\
+			__r->reg[2] =3D r2;				\
+			__r->reg[3] =3D r3;				\
+			__r->reg[4] =3D r4;				\
+			__r->reg[5] =3D r5;				\
+			__r->reg[6] =3D r6;				\
+			__r->reg[7] =3D r7;				\
+			ARM64_ADDITIONAL_RESULTS			\
+		}							\
+	} while (0)
+
+#define arm_smccc_1_2_smc(args, res)					\
+	__arm_smccc_1_2(SMCCC_SMC_INST, args, res)
+
+#define arm_smccc_1_2_hvc(args, res)					\
+	__arm_smccc_1_2(SMCCC_HVC_INST, args, res)
+
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/

