Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896C911E211
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 11:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMKgm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Fri, 13 Dec 2019 05:36:42 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:39213 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfLMKgm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 05:36:42 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri, 13 Dec 2019 10:35:33 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 13 Dec 2019 10:33:08 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 13 Dec 2019 10:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCWAzDALm7I7z2oiWxgsTsvZbuuDr6ivKq72GSlNJWqcywgHmu8w6/6rUHgvD41FMcg4ydLYyoVyzlAlXxMNHYlPH5pr1/ehK9S1p1mRH7mNzesQ6BU96Si6dM0UWJAPon+Xy5Yu3SG+028Jvmb8MJVeJPx4QbJmQkYmzz0270ji4UJwisldbEFTVyiPzjAmMa0lAcQ123Km1yhr9bBpd0eedS8BHowzOkYzPWmhJUf8zTYxqPx1RSzTnb5Olzw4DD9wURL/7GdhJCyKT862FY63/s5USGPyct7yfK1otAijEjMG4ulteKRnHerEwU6upaTJ8bvnHK6pH5/ZvlastQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmtsLqEKdOsCPv3Pfm6yBBef/UA0dNIhpxtV6sQWh4U=;
 b=Gsyy+W/eJbPZpXsqWa6+/u/hCvr5iAQfzsMYH3vz76VtCSnNB2lLvrY9mXCP5xybSKnQkCfFCNjLIMiLGlJvQRENoAA3Gp1OiO4KkU9mNpot3OvwEBqZ0vB/FkGqBzwe5PF32U5pkmWob3ZFCZZouhtyXMhLIqjkPa89gZUPhPMP7XkyMWWNgZvnlGz3BJhTQ5i3SmLCn8gqIRAXvvwh84N1athXla+uD+W5+CRBkCdipLxA7uYSJjBgdLVlxPEzxfeXMjzSvKI1gKZYrn634cEKgUF1E0+EEnF9T5hxXMDRoGfRcIKapXYd12+zyWcPs/PGdVoqOuUOjYpZqVawog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com (10.164.204.162) by
 MWHPR1801MB1823.namprd18.prod.outlook.com (10.164.206.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Fri, 13 Dec 2019 10:33:07 +0000
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc]) by MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc%6]) with mapi id 15.20.2538.016; Fri, 13 Dec 2019
 10:33:07 +0000
From:   Joey Lee <JLee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status code to
 a string
Thread-Topic: [PATCH 1/2 v2] efi: add a function to convert the status code to
 a string
Thread-Index: AQHVsZyj5qs/M6p/ZE6QTjf9u49o3Ke33iWA
Date:   Fri, 13 Dec 2019 10:33:06 +0000
Message-ID: <20191213103257.GZ22409@linux-l9pv.suse>
References: <20191213090646.12329-1-jlee@suse.com>
 <20191213090646.12329-2-jlee@suse.com>
 <CAKv+Gu8sGku8e1q9ku_wXfcXTGQ5W8Lt_q5KEK9WycgHw15TgA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8sGku8e1q9ku_wXfcXTGQ5W8Lt_q5KEK9WycgHw15TgA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To MWHPR1801MB1919.namprd18.prod.outlook.com
 (2603:10b6:301:68::34)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36da4c1b-66cb-4556-1b8a-08d77fb7d794
x-ms-traffictypediagnostic: MWHPR1801MB1823:
x-microsoft-antispam-prvs: <MWHPR1801MB1823CFDD6CAE49BC63E83044A3540@MWHPR1801MB1823.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(199004)(189003)(186003)(81166006)(8676002)(4326008)(81156014)(316002)(66556008)(66946007)(6486002)(64756008)(66476007)(66446008)(8936002)(54906003)(2906002)(6916009)(36756003)(52116002)(86362001)(478600001)(6512007)(9686003)(26005)(33656002)(55236004)(1076003)(5660300002)(71200400001)(7416002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1801MB1823;H:MWHPR1801MB1919.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4y+iGCTNAYi9jDZLqNHDGoEFfLHnmR3aYGihYu3NYo+28mYTmQNiXdAPmeTqfMuihV96i3Ezhdy3I6mKkSeMuhYCXOt24IMX3ZMQlN/YI0v95gtBP12BuvnXARewPq3FStFeDFnLXGFIb1osuBSffmcXXQDVFSujAAUd8w2rU3tShsEpfY09TelRXFOImwBDGW8hv83eDmWe+HCeuDJXB0jOcTwkANaoocx4ck9Y4oIM4z5Rnizjm7aqZeoBQjv3WhUkWkSyazpRlns7yeNlxBLfA4r1yzACBuS8FQw7Orp8FuT81iIs13JWA1ZecX3y9S3uDFDkf4Vjg7R3BwNviRoRGjO7FJeYxZly0PyYqHUpwajzQoefxwrKeJ4DxzJIK+wrJT8qx040jxjdJ94Mxft1rc7UBen795JfcvKkTcux9XyFrZmHuiCsmfvYshc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99E0293FC8DCC9458A013C3B0A0E92A7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36da4c1b-66cb-4556-1b8a-08d77fb7d794
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 10:33:06.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWS9EypBOFqadQMP6zQB1XbH0uTkrmwMPJ7R+Cy7/IpWDs9N9ULKLjsqLZ/g4ukZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1823
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 13, 2019 at 10:03:27AM +0000, Ard Biesheuvel wrote:
> On Fri, 13 Dec 2019 at 10:07, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This function can be used to convert EFI status code to a string
> > to improve the readability of log.
> >
> > v2:
> > Moved the convert function to efi.c
> >
> 
> Please put the patch series revision log below the ---

OK! I will move to below the --- next time.

> 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>

Thanks for your review!
 
> > ---
v2:
Moved the convert function to efi.c
> >  drivers/firmware/efi/efi.c | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/efi.h        |  1 +
> >  2 files changed, 33 insertions(+)

Do you mean move the revision log to here like the above?

Thanks a lot!
Joey Lee

> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index e98bbf8e56d9..8bdc1c17eb5d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -954,6 +954,38 @@ int efi_status_to_err(efi_status_t status)
> >         return err;
> >  }
> >
> > +#define EFI_STATUS_STR(_status) \
> > +       EFI_##_status : return "EFI_" __stringify(_status)
> > +
> > +const char *efi_status_to_str(efi_status_t status)
> > +{
> > +       switch (status) {
> > +       case EFI_STATUS_STR(SUCCESS);
> > +       case EFI_STATUS_STR(LOAD_ERROR);
> > +       case EFI_STATUS_STR(INVALID_PARAMETER);
> > +       case EFI_STATUS_STR(UNSUPPORTED);
> > +       case EFI_STATUS_STR(BAD_BUFFER_SIZE);
> > +       case EFI_STATUS_STR(BUFFER_TOO_SMALL);
> > +       case EFI_STATUS_STR(NOT_READY);
> > +       case EFI_STATUS_STR(DEVICE_ERROR);
> > +       case EFI_STATUS_STR(WRITE_PROTECTED);
> > +       case EFI_STATUS_STR(OUT_OF_RESOURCES);
> > +       case EFI_STATUS_STR(NOT_FOUND);
> > +       case EFI_STATUS_STR(ABORTED);
> > +       case EFI_STATUS_STR(SECURITY_VIOLATION);
> > +       }
> > +       /*
> > +        * There are two possibilities for this message to be exposed:
> > +        * - Caller feeds a unknown status code from firmware.
> > +        * - A new status code be defined in efi.h but we forgot to update
> > +        *   this function.
> > +        */
> > +       pr_warn("Unknown efi status: 0x%lx\n", status);
> > +
> > +       return "Unknown efi status";
> > +}
> > +EXPORT_SYMBOL(efi_status_to_str);
> > +
> >  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> >  static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index d87acf62958e..2c6848d2b112 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1228,6 +1228,7 @@ efi_capsule_pending(int *reset_type)
> >  #endif
> >
> >  extern int efi_status_to_err(efi_status_t status);
> > +extern const char *efi_status_to_str(efi_status_t status);
> >
> >  /*
> >   * Variable Attributes
> > --
> > 2.16.4
> >
