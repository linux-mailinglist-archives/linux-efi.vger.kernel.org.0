Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0287BF2907
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 09:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKGIYA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 7 Nov 2019 03:24:00 -0500
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:36696 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfKGIX7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Nov 2019 03:23:59 -0500
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Thu,  7 Nov 2019 08:22:50 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 7 Nov 2019 08:21:41 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 7 Nov 2019 08:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8S3nwjYdQYp5d6nHUJ9j8qeyDOM2DwIo0wc5wQ5Lr3g8d+3N1mdjBP0MN2LKqw5kGZO1O8i0gbSEoXeEU/aghra/0BiraYXNQCXxwwMxZUG6apt28u1RYgBxHUeTH/+pIGhJ+vm7AcKBseAOAaQ+b9wbAIPG1oDSnRu8TUcUy6tixrhY8Lb8imHjKyVzHOltYP7QHycOndeaXD3q3m5MvZFidF/dVcIIMT3r1Yqr86iDWmFbR9jGwqwWICJxqs3Siex50jPUic53y9H4Y6aGTbCSpSEvK8pBrvMDb9UY5SfZBxXq736yu4XjhMha+Th9pOv5Lho2Ce46eiLcVjZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw1gX5UmsSpwOfFbQ4O12YDndiNAwwEx9Oe3l9ve42g=;
 b=OPYHU2xEqbTNh3wctgQ1IY+O2xWFvaN4R1PVdX8yKTI6J6r0cS8poojHB542PXoZrOaVvg1Ny9Z7Gl7l0Wc4sTWMeEMmijTuLgLnrO4MJD57CroU1UCDw1lRtkysoyC8XMHvVbviYk9QWn5Vt13JQE3umBInNpwiQ5EN42dYL2o9gLzXfxhIg6C5XmUBC8y6mIDP/w0G2QzXXqp83ZHCxQpwaWOui0E+T54OBdc4WDuMU0GVJCSnwWVqTbo33BTXqSebL4zynmsgESgorXWIiiLWRA35mlU3rr75VvbbWT37S1jKun8WarHK3OTY/xfyHklkPHC/AAWjmDCXTtmDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com (10.164.204.162) by
 MWHPR1801MB2063.namprd18.prod.outlook.com (10.164.205.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 08:21:40 +0000
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::7106:bd76:41b8:ef03]) by MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::7106:bd76:41b8:ef03%3]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 08:21:40 +0000
From:   Joey Lee <JLee@suse.com>
To:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     David Howells <dhowells@redhat.com>,
        "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jforbes@redhat.com" <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 18/30] acpi: Disable APEI error injection if the kernel is
 locked down
Thread-Topic: [PATCH 18/30] acpi: Disable APEI error injection if the kernel
 is locked down
Thread-Index: AQHVlURhP/mEXrsc5kO6jxmwyldIMQ==
Date:   Thu, 7 Nov 2019 08:21:40 +0000
Message-ID: <20191107082131.GI12016@linux-l9pv.suse>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
 <151024877315.28329.472560163492858160.stgit@warthog.procyon.org.uk>
In-Reply-To: <151024877315.28329.472560163492858160.stgit@warthog.procyon.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To MWHPR1801MB1919.namprd18.prod.outlook.com
 (2603:10b6:301:68::34)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cd6a720-fabc-4209-8354-08d7635b83a7
x-ms-traffictypediagnostic: MWHPR1801MB2063:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MWHPR1801MB20639C911CED73A4CE8E5428A3780@MWHPR1801MB2063.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(189003)(199004)(6436002)(6116002)(66556008)(64756008)(6916009)(4326008)(54906003)(66946007)(6246003)(305945005)(229853002)(5660300002)(478600001)(7736002)(14444005)(3846002)(102836004)(966005)(26005)(25786009)(8676002)(81166006)(66446008)(5640700003)(81156014)(256004)(99286004)(446003)(14454004)(11346002)(6512007)(486006)(476003)(66066001)(316002)(66476007)(2906002)(52116002)(55236004)(33656002)(86362001)(2351001)(6506007)(6486002)(80792005)(386003)(6306002)(186003)(2501003)(76176011)(36756003)(71190400001)(8936002)(71200400001)(9686003)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1801MB2063;H:MWHPR1801MB1919.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeWK8XqBa9xqhG7w60uK8focqfbPjbheloLT+mxm345b8EQRf6acNRZssE3n+/2j4c+g0RepNnD28IJ3VDkOHTcidAcj9sa+WQc16ssDVWS76YZyNtDiMrdkg8Hes5MOXKroacwf+bFiJsN3FWr+/0gDxASY0Wlq4seRqx0yy8CMxcOPNJffYjWlPnRw8a6GUec2sty4Sj5zkvrrD8b45Fm9o4SyjozISWB/IqKpoaCPauYFqZgNPHu+J5IQ00hnT50hW4UM+koywugXXWS1hy+8b+91pG+58sWAFUoRznDNRk3LDMTJ9EAbMyk5PbJDxap05LdmgTCmUV+kAnn5TpLwkExo2jt9mEx2xbX+rmc1tRgHwBqOs3mY+Rk+FDjoU7zNMUreqbk7rJAIlVnIHJ4EIMEPzCq5WlbLYWn8KwMbjiV85zVSor5/ABoleE8GhOwajcFeWX2XeP08i/xk6MdN1H9cN5HkvQ911m7XVEM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA7B6F7E6050AA4F9C89EDDE76B4B210@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd6a720-fabc-4209-8354-08d7635b83a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:21:40.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+53XOdLW5OJVsvsRWw+II3NTjP3RQ2cbDxXaOY4lnqdCKGeHujPlamNf467ATeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2063
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi experts,

On Thu, Nov 09, 2017 at 05:32:53PM +0000, David Howells wrote:
> From: Linn Crosetto <linn@hpe.com>
> 
> ACPI provides an error injection mechanism, EINJ, for debugging and testing
> the ACPI Platform Error Interface (APEI) and other RAS features.  If
> supported by the firmware, ACPI specification 5.0 and later provide for a
> way to specify a physical memory address to which to inject the error.
> 
> Injecting errors through EINJ can produce errors which to the platform are
> indistinguishable from real hardware errors.  This can have undesirable
> side-effects, such as causing the platform to mark hardware as needing
> replacement.
> 
> While it does not provide a method to load unauthenticated privileged code,
> the effect of these errors may persist across reboots and affect trust in
> the underlying hardware, so disable error injection through EINJ if
> the kernel is locked down.
> 
> Signed-off-by: Linn Crosetto <linn@hpe.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> cc: linux-acpi@vger.kernel.org

I was looking at the lockdown pathes in v5.4-rc kernel and found that the
"acpi: Disable APEI error injection if the kernel is locked down" did not
merged with lockdown patch set. This patch be sent with Matthew's pull
request lockdown patches for 5.2:
    http://kernsec.org/pipermail/linux-security-module-archive/2019-March/012033.html

But it didn't show in Morris's git:
    https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=next-lockdown

Maybe I missed some detail of this patch. Could anyone point out the
concern of this patch please?

> ---
> 
>  drivers/acpi/apei/einj.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b38737c83a24..6d71e1e97b20 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	int rc;
>  	u64 base_addr, size;
>  
> +	if (kernel_is_locked_down("ACPI error injection"))
> +		return -EPERM;
> +
>  	/* If user manually set "flags", make sure it is legal */
>  	if (flags && (flags &
>  		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Joey Lee
