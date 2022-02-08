Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3F4ADA73
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 14:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbiBHNzT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 08:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBHNzS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 08:55:18 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2093.outbound.protection.outlook.com [40.92.103.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B4C03FED0;
        Tue,  8 Feb 2022 05:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMqUULbRFFZQ8L47TZgrdfRRzzF4jos38KJkarflPfCNUgNoRndRLbX+T2oZs6r8s1pjD1HCG/w2u+vB0M6RMgddH+srX7Xe/U0tV6PaW/v7H8ZWS+EIrWhaXTyAbKaAYw1jw6dW2v7OX+6Z+J+EOgRfD/l+L7Sbup7A1AOmSk0pStg6bk/Rgv+M+8on9VOAA/b6mqORXDeOigpCfOLLMOZkhWfid/G542z+k4fWUuzd2yDDjDOuQ3WH0r3DJgJ8Ea3sgTG75uerfuboylOODaYVCP1jD27kX5e02AVIq6kE/Hf9s4KMm40NzIEsx3KO2j5iFlMq3/EUExWNUaLanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UKar/Cs//h3SyE3Ui/wLYGvma1Vy8u1S0ZxtbW0AT4=;
 b=jj2WKklUJDpIa0vMRSbLSDIR3pBKiuHTvZNOHPYULeAtgP7WjuzinTWW/tobWL1U6sxwMOvljdZdlaJgJDALJoXMDWQUwF0wB9hSMuztTvS9SVDK8QXqa93HxtOM/aWyRKkCgpHZQwy5LusP9TO6KaUO1p4jusFPMaZwgzVK02TOiqBYV6EZlD3Go7IUBHNheOkjMJjzbm5LhxHnaPUd520EJPtNbbtxSK1VD3bU8c8Az1vi1IjSmA56j6hqgoZv0JkQJoTB8lEamaUu48eoDu7Vjbt9fbUm6PJ/I6Oa28VVplj2mfPwzjEW+a3zbK+O/7KejZfny0Vtgoj6r+9QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UKar/Cs//h3SyE3Ui/wLYGvma1Vy8u1S0ZxtbW0AT4=;
 b=VcysI8v80qIBzM3mw0cJry++TsjBZlAbhuoQWiNBUikWPy5ba3aauhdySSZ4yIf666b1OM5IxqZSCxaukc2OvLkbMHBLLfJcYz7odSzcMrnoOS1MrKz/IE5Gp3d02Ovs3cBmveMOJLYxMrwbNDFx6LG2KoE2uZljVNUv8uLiKGHCf9vpaMnr9hcnb70fajYvVtWezp5CdF7tT02C6QaVJbgmhjU89SJfTyqtnE6+b+rOAOaGqeNaCu4TXicZL0f44SGQhiM0xU+V5t3rI9F7s88m1wVOwPlmHkEJ8BJXThGY1NRz/h9bnhdiup5W8P1EtzxHl4F1RU0kqDzGJM4Qdg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MAZPR01MB7070.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:44::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 8 Feb
 2022 13:55:11 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 13:55:11 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG SEVERE] Failure to enable EFI Runtime services on T2 Macs
Thread-Topic: [BUG SEVERE] Failure to enable EFI Runtime services on T2 Macs
Thread-Index: AQHYHPN9ZhdEJnJFlkmeAh3YlD43NA==
Date:   Tue, 8 Feb 2022 13:55:11 +0000
Message-ID: <E5DB4C43-F2AB-412A-9891-C13255374AD9@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RgZv/MV7iLTq2MplCS52yGcQljJjEWQVZS9R2DdJmQL0E77rhRsDExM+MAQeop8H]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5930ecc-ecd8-42c3-d0a1-08d9eb0a9ffa
x-ms-traffictypediagnostic: MAZPR01MB7070:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUhcFHEAJ920q0Dbqq83jP4OHwPsCWF5Aeq2LceuiPAHjM6TkxeGr3W6nc9jgnIYEtNjqvMB+uqj0AWnArPonvtoEvlmX0jlkrlw665xpqOoSgU9KBZsLWnnlBEeI70VN8cOUhz8uCv1pbFJaYSjfjUB4huuC7wXx2KUet3vKj6nL0tPRJmIgaNheu5W84q3eGDLd0uqhGvj67rNnF4tV2+1XIY5xJI+YzcIi3RCL6z7Snkf6xObuIyQvwyOnMfBvfA3UOuNw9DliJxOfaLdjSquRISEfyifym6hQZ9SCt96MFsYOw2BHFPgjFqAGhfO1v7D9nasjVN5o5+N3Ry3KuzBixBe7sYkgShMxD61jRmK6NB9mj+xLVzGl8wE4M37JJHVnG33VoxvZh4tQx5kjwN3DsyKpzGwzkufuqYlKoTpeFvm1QKpqOMMCvZAYNm4S7ARoHlDV1FgKFmtzJ+Fb2cZfjgj0/DE7yDUvGEwWTVoNVtirYcv4hali4GVZV5iiLD5WemQ754jhH2coI5DHeNMvFsME1KNhPINQpgeN5uvm/ZAe22DfPN3xaWwSrB2WAzWaK/5w+pqS5NLrOysWarpKIv7M2ePXNn+glgcMwcTSqRwWWfUySXmlklgMk2h5a+iUTUMu5V2cwSBo8zqQxkkCA/HCxNrhHyWFg69YIw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQOrzMz9+8ruT/kAOZtbMcMzvAroHAcKKCKibxy0+X0lV2iyCyiiVyjzx3Av?=
 =?us-ascii?Q?9fcw6EKi/qLIz/EaCOnRPyQ8GhXm1EB2c/oXdMRo/5FL+iH/ZpsUdq8Ts66u?=
 =?us-ascii?Q?JSbzL5QsX1Xzy2ygkvHT4HIpWLc5pyOf+YL/xAgdJctdZGd2LCtWsFkiphI9?=
 =?us-ascii?Q?DmrEMm8cj3f1+uwM46UjKN8YM9ynksjXxKbGTAlc6Cqhi3eq3joRBpi6cotJ?=
 =?us-ascii?Q?a/oo0vWxS3Yf5DTmbavU+vVXHLSd3wuBjrqZeZGOXkHNl+dWTjwfl+4FxdxI?=
 =?us-ascii?Q?O7AbeeKbJQyLfoq8jv3hz38algRJ3InsqGppCqAiYdpnaqo4oT919LeLwecC?=
 =?us-ascii?Q?DuCVImr7FUBgpNrkHlgxz43sK9S0GSfX3ctyNsnSAu9E4S4eVbQ3QqVfTJ8V?=
 =?us-ascii?Q?XMAv7e8/3Rhwcz3Bw8plT0MIcQHh5xAXWnShGZBK7tsBGDDG0oKRBX2OHWGs?=
 =?us-ascii?Q?Xp9hpHwQD97Ir1d2c0oMGxgElagLWME7MNJJvwtutPTb/nG5wuJE+P5WsiEL?=
 =?us-ascii?Q?NQCIfOtrOk4VNs7Xm8IPtsxWbjPQYAOdpVXVyAoo6MxRWhiTNYITsePWPR1K?=
 =?us-ascii?Q?5XuIvJblU/pm3fdLFkkNEfZbGYayZTzwhdkbBWq0pMyLiR+OaD9Q0O4tBPUz?=
 =?us-ascii?Q?ayS4QpK0Zrnv0t99/sH8Sg+PtF5jT5ZpUa8GP7htmuZnQpMRh+PfYp4GapOI?=
 =?us-ascii?Q?HILsgQ8YKOKHDVGkD0zCZ5tylJKR0tUULmarsxGlqTroifMGs6mpRY/Ow9Vs?=
 =?us-ascii?Q?MPx1jYLpnmhG4ZYFvpzgAjswsSNfMw5J9+96a1SCnne9B6bly82q7Gti4d5D?=
 =?us-ascii?Q?6HqKKBa8gIU+dCTRGQvicF0v+97axJX2o+mun+xJpWwpaiUE7irNI18pLLl6?=
 =?us-ascii?Q?faDxiUVJfnSF/dskUzMsnkzBJc0xayNR/PlEqFUFrT4dkniAzxhkPoFiMbI7?=
 =?us-ascii?Q?SXO6bgLF0Ed1Oud+zYHG6zO6Ooz9liCFitixgCtaB3mTqu9CxLrXu7OH+mEm?=
 =?us-ascii?Q?0reFC6M9k0R/VvnXDXWmKJcCZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F85594B20D8F4438E1E1D5204BFFA20@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f5930ecc-ecd8-42c3-d0a1-08d9eb0a9ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 13:55:11.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7070
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On using some specific kernel configuration, on Macs with the T2 Security c=
hip, EFI Runtime services fail to start. Some logs which may be useful are =
as follows :-

Feb 08 17:11:11 MacBook kernel: [Firmware Bug]: Page fault caused by firmwa=
re at PA: 0xffffa79840068000
Feb 08 17:11:11 MacBook kernel: WARNING: CPU: 11 PID: 150 at arch/x86/platf=
orm/efi/quirks.c:735 efi_crash_gracefully_on_page_fault+0x50/0xd0
Feb 08 17:11:11 MacBook kernel: Modules linked in:
Feb 08 17:11:11 MacBook kernel: CPU: 11 PID: 150 Comm: kworker/u24:1 Not ta=
inted 5.15.19-t2 #2
Feb 08 17:11:11 MacBook kernel: Hardware name: Apple Inc. MacBookPro16,1/Ma=
c-E1008331FDC96864, BIOS 1715.81.2.0.0 (iBridge: 19.16.10744.0.0,0) 01/06/2=
022
Feb 08 17:11:11 MacBook kernel: Workqueue: efi_rts_wq efi_call_rts
Feb 08 17:11:11 MacBook kernel: RIP: 0010:efi_crash_gracefully_on_page_faul=
t+0x50/0xd0
Feb 08 17:11:11 MacBook kernel: Code: fc e8 b4 fb 02 00 49 81 fc ff 0f 00 0=
0 76 08 48 3d 30 9e dc a8 74 04 41 5c 5d c3 4c 89 e6 48 c7 c7 20 c5 1b a8 e=
8 9f 7f bb 00 <0f> 0b 83 3d 57 56 12 02 0a 0f 84 89 6f bb 00 e8 9c 1a 00 00=
 48 8b
Feb 08 17:11:11 MacBook kernel: RSP: 0000:ffffa79840592a08 EFLAGS: 00010086
Feb 08 17:11:11 MacBook kernel: RAX: 0000000000000000 RBX: ffffa79840592a48=
 RCX: ffffffffa857a088
Feb 08 17:11:11 MacBook kernel: RDX: 00000000ffffdfff RSI: ffffa79840592848=
 RDI: 0000000000000000
Feb 08 17:11:11 MacBook kernel: RBP: ffffa79840592a10 R08: 0000000000000003=
 R09: 0000000000000001
Feb 08 17:11:11 MacBook kernel: R10: 0000000000ffff10 R11: 000000000000000f=
 R12: ffffa79840068000
Feb 08 17:11:11 MacBook kernel: R13: 0000000000000000 R14: ffffa79840592b98=
 R15: ffff897a816a3200
Feb 08 17:11:11 MacBook kernel: FS:  0000000000000000(0000) GS:ffff897deecc=
0000(0000) knlGS:0000000000000000
Feb 08 17:11:11 MacBook kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Feb 08 17:11:11 MacBook kernel: CR2: ffffa79840068000 CR3: 00000001001ea002=
 CR4: 00000000003706e0
Feb 08 17:11:11 MacBook kernel: Call Trace:
Feb 08 17:11:11 MacBook kernel:  <TASK>
Feb 08 17:11:11 MacBook kernel:  page_fault_oops+0x4f/0x2b0
Feb 08 17:11:11 MacBook kernel:  ? search_bpf_extables+0x63/0x80
Feb 08 17:11:11 MacBook kernel:  ? search_exception_tables+0x5b/0x60
Feb 08 17:11:11 MacBook kernel:  kernelmode_fixup_or_oops+0x9e/0x110
Feb 08 17:11:11 MacBook kernel:  __bad_area_nosemaphore+0x155/0x190
Feb 08 17:11:11 MacBook kernel:  bad_area_nosemaphore+0x16/0x20
Feb 08 17:11:11 MacBook kernel:  do_kern_addr_fault+0x62/0x80
Feb 08 17:11:11 MacBook kernel:  exc_page_fault+0xd8/0x160
Feb 08 17:11:11 MacBook kernel:  asm_exc_page_fault+0x1e/0x30
Feb 08 17:11:11 MacBook kernel: RIP: 0010:0xfffffffeefc440c5
Feb 08 17:11:11 MacBook kernel: Code: 31 c9 48 29 f9 48 83 e1 0f 74 0c 4c 3=
9 c1 49 0f 47 c8 49 29 c8 f3 a4 4c 89 c1 49 83 e0 0f 48 c1 e9 04 74 2c f3 0=
f 7f 44 24 18 <f3> 0f 6f 06 66 0f e7 07 48 83 c6 10 48 83 c7 10 e2 ee 0f ae=
 f0 66
Feb 08 17:11:11 MacBook kernel: RSP: 0000:ffffa79840592c48 EFLAGS: 00010286
Feb 08 17:11:11 MacBook kernel: RAX: fffffffeefc92256 RBX: ffffffffa82127ba=
 RCX: 0000000000000032
Feb 08 17:11:11 MacBook kernel: RDX: ffffa79840067d20 RSI: ffffa79840067ffa=
 RDI: fffffffeefc92530
Feb 08 17:11:11 MacBook kernel: RBP: ffffa79840592cd0 R08: 000000000000000d=
 R09: ffffa79840068326
Feb 08 17:11:11 MacBook kernel: R10: fffffffeefc8e018 R11: 0000000000085dc9=
 R12: 0000000000000000
Feb 08 17:11:11 MacBook kernel: R13: ffffa79840067db0 R14: ffffa79840067d01=
 R15: 0000000000000607
Feb 08 17:11:11 MacBook kernel:  ? __efi_call+0x28/0x30
Feb 08 17:11:11 MacBook kernel:  ? switch_mm+0x20/0x40
Feb 08 17:11:11 MacBook kernel:  ? efi_call_rts+0x189/0x6f0
Feb 08 17:11:11 MacBook kernel:  ? process_one_work+0x22b/0x3d0
Feb 08 17:11:11 MacBook kernel:  ? worker_thread+0x4d/0x3f0
Feb 08 17:11:11 MacBook kernel:  ? process_one_work+0x3d0/0x3d0
Feb 08 17:11:11 MacBook kernel:  ? kthread+0x12a/0x150
Feb 08 17:11:11 MacBook kernel:  ? set_kthread_struct+0x40/0x40
Feb 08 17:11:11 MacBook kernel:  ? ret_from_fork+0x22/0x30
Feb 08 17:11:11 MacBook kernel:  </TASK>
Feb 08 17:11:11 MacBook kernel: ---[ end trace b0e21a194e80a466 ]---
Feb 08 17:11:11 MacBook kernel: efi: Froze efi_rts_wq and disabled EFI Runt=
ime Services
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: MODSIGN: Couldn't get UEFI db li=
st
Feb 08 17:11:11 MacBook kernel: efi: EFI Runtime Services are disabled!
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get UEFI dbx list
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get mokx list
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get UEFI MokListRT
Feb 08 17:11:11 MacBook kernel: ima: No TPM chip found, activating TPM-bypa=
ss!
Feb 08 17:11:11 MacBook kernel: Loading compiled-in module X.509 certificat=
es
Feb 08 17:11:11 MacBook kernel: Loaded X.509 cert 'Build time autogenerated=
 kernel key: 4fe3a063ebcd82317099edaaf5ee8e3719392e6e'
Feb 08 17:11:11 MacBook kernel: ima: Allocated hash algorithm: sha1
Feb 08 17:11:11 MacBook kernel: ima: No architecture policies found
Feb 08 17:11:11 MacBook kernel: evm: Initialising EVM extended attributes:
Feb 08 17:11:11 MacBook kernel: evm: security.selinux
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64EXEC
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64TRANSMUTE
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64MMAP
Feb 08 17:11:11 MacBook kernel: evm: security.apparmor
Feb 08 17:11:11 MacBook kernel: evm: security.ima
Feb 08 17:11:11 MacBook kernel: evm: security.capability
Feb 08 17:11:11 MacBook kernel: evm: HMAC attrs: 0x1
Feb 08 17:11:11 MacBook kernel: PM:   Magic number: 10:872:680
Feb 08 17:11:11 MacBook kernel: RAS: Correctable Errors collector initializ=
ed.
Feb 08 17:11:11 MacBook kernel: Freeing unused decrypted memory: 2036K
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (initmem) memor=
y: 2952K
Feb 08 17:11:11 MacBook kernel: Write protecting the kernel read-only data:=
 24576k
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (text/rodata ga=
p) memory: 2036K
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (rodata/data ga=
p) memory: 540K
Feb 08 17:11:11 MacBook kernel: x86/mm: Checked W+X mappings: passed, no W+=
X pages found.
Feb 08 17:11:11 MacBook kernel: x86/mm: Checking user space page tables
Feb 08 17:11:11 MacBook kernel: x86/mm: Checked W+X mappings: passed, no W+=
X pages found.
Feb 08 17:11:11 MacBook kernel: Run /init as init process
Feb 08 17:11:11 MacBook kernel:   with arguments:
Feb 08 17:11:11 MacBook kernel:     /init
Feb 08 17:11:11 MacBook kernel:     splash
Feb 08 17:11:11 MacBook kernel:   with environment:
Feb 08 17:11:11 MacBook kernel:     HOME=3D/
Feb 08 17:11:11 MacBook kernel:     TERM=3Dlinux
Feb 08 17:11:11 MacBook kernel:     BOOT_IMAGE=3D/boot/vmlinuz-5.15.19-t2
Feb 08 17:11:11 MacBook kernel: ACPI: video: [Firmware Bug]: ACPI(GFX0) def=
ines _DOD but not _DOS
Feb 08 17:11:11 MacBook kernel: ACPI: video: Video Device [GFX0] (multi-hea=
d: yes  rom: no  post: no)


The kernel configuration where this bug is seen is on https://github.com/t2=
linux/T2-Ubuntu-Kernel/blob/Mainline/templates/default-config

I had an old kernel configuration, where I did not face this issue and was =
easily able to write to the NVRAM. That kernel configuration is on https://=
github.com/t2linux/T2-Ubuntu-Kernel/blob/b5c20b8c7689251dd943e22dbe02cef902=
0db8d1/templates/default-config

I believe these lines in the kernel config, which are present in the former=
 but absent in the latter are causing the issue :-


CONFIG_SECURITY_LANDLOCK=3Dy
CONFIG_INTEGRITY=3Dy
CONFIG_INTEGRITY_SIGNATURE=3Dy
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy
CONFIG_LOAD_UEFI_KEYS=3Dy
CONFIG_INTEGRITY_AUDIT=3Dy
CONFIG_IMA=3Dy
CONFIG_IMA_MEASURE_PCR_IDX=3D10
CONFIG_IMA_LSM_RULES=3Dy
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=3Dy
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH=3D"sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=3Dy
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
CONFIG_IMA_APPRAISE_MODSIG=3Dy
CONFIG_IMA_TRUSTED_KEYRING=3Dy
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy

Especially CONFIG_LOAD_UEFI_KEYS=3Dy is which I guess may be the culprit.

I request you to reply to my issue as soon as possible

Thanks
Aditya=
