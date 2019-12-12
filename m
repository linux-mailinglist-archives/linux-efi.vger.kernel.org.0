Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E154511D019
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 15:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfLLOn7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 12 Dec 2019 09:43:59 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:46920 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729266AbfLLOn6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 09:43:58 -0500
X-Greylist: delayed 1021 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 09:43:57 EST
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Thu, 12 Dec 2019 14:42:50 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 12 Dec 2019 14:24:09 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 12 Dec 2019 14:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/85qc2puIMnQ9rOu1YuLHZXcdeKEzbQ1z4bxrab56+rMXF9/1DFvzYlKVRgAphpY+KSuki7FR6NYRMt4OULTD9o30Z81rmsiT5ig80eWyRjydW0CclvRp+HAcJyb9jZ9g0P+bBNRzEbt6s71SsWvEDaKbsmfdIW0MohOuuLCKVhS2GE42wlkwKXOqogpxYhicfCjcCMtzrofZv2nBIU/HjdYG2p7JXTZGIXJpMVPXOhCqMHxB3D3Ioiiv2B8uYCcJRNUsakKapQRlD/Spo/f5OMl5OgBW9GNchB7fcY4yHM92c3HNsPiCACi1v9SbQgfQ0svmdBwwio8pNnRlKG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYcWYYx4aNd4ZoGxqjCHcp6dGFD4ea9UwZFDnZTf6Mw=;
 b=m5ClFb1VpCa+vdzWHSX55ioWAGqqoTcuQJu/1eJ708i3CpUH7+5L/m5neQSuKzsPJa/HantoWG3+YS8ULtc8KOVVT4tNZ7cGE0HL5DB/27nqixAMjbJDfQM39F5+x0+HyMlkYlE1nhbg4ky3W7otKBRWE5bvfTUxY2h3wWWeJLStZdLdzfnlGB/uS3GTxRehOXojYQcV0pE1p/Je1mSL7t8/c2s/yGq0WUhKPL6ZhyuoRU404USH50RnRxMrOVrfy9M0l5jszZ0c7hpFGEIMG3Ngc5F9/otsk914oe/fNvFUDw7Q/SC+qxpX7XvUal9Cd+Da5Gvy1jSCi0hsae7c8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com (10.164.204.162) by
 MWHPR1801MB1903.namprd18.prod.outlook.com (10.164.204.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 12 Dec 2019 14:24:08 +0000
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc]) by MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc%6]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 14:24:08 +0000
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
Subject: Re: [PATCH 1/2] efi: add a function for transferring status to string
Thread-Topic: [PATCH 1/2] efi: add a function for transferring status to
 string
Thread-Index: AQHVsN48IHC/EIELJUajHOSd7WDsoqe2jdeA
Date:   Thu, 12 Dec 2019 14:24:07 +0000
Message-ID: <20191212142357.GV22409@linux-l9pv.suse>
References: <20191212093812.10518-1-jlee@suse.com>
 <20191212093812.10518-2-jlee@suse.com>
 <CAKv+Gu83Ndu8XWDAUTmHu6udRCXbodqzTyq5wZJvfGiLfidwbw@mail.gmail.com>
In-Reply-To: <CAKv+Gu83Ndu8XWDAUTmHu6udRCXbodqzTyq5wZJvfGiLfidwbw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To MWHPR1801MB1919.namprd18.prod.outlook.com
 (2603:10b6:301:68::34)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [124.11.22.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc41a153-7339-4526-0aeb-08d77f0ef2e4
x-ms-traffictypediagnostic: MWHPR1801MB1903:
x-microsoft-antispam-prvs: <MWHPR1801MB1903954AE816DDEA0A528ADDA3550@MWHPR1801MB1903.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(52116002)(6916009)(71200400001)(6506007)(4326008)(33656002)(5660300002)(6486002)(54906003)(316002)(86362001)(26005)(7416002)(81166006)(8936002)(81156014)(8676002)(64756008)(66446008)(2906002)(66476007)(478600001)(66946007)(186003)(36756003)(66556008)(1076003)(6512007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1801MB1903;H:MWHPR1801MB1919.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fHawgUt6+3KfPzsPjMjc17otrOR5X2kZm5NPcG851FORpE5SA3TXH6NTO232TNTJkZXEaR2UTrJD0Y8bDr3e15XTP8IYdvYIydJFlXTKMOwE39WADw1+nIuJg65XVZJQA1pYC6XdDTb92Bduo5LJVq+urqyxN9+OW+iox2w8BiN+RqgJt3rL7XDpslLDdCwgr9Q4I2zgr58N4oC9FxoBVIWn8kPvQGQb8RwSeI0Md1+EsdlDlEQzaIsqUqHVf90mua2JbojDK8dPZWh5e7OFek7CRPOHA79bEU+uFlT8iGmrR4eWFJKn+d6XvFESDteph7jKcXsjS6nZShGYY/pI9FFr5y5poF6VtnSlz+Vkfj/esoTL9nJwahsTfjMmbNr+R22uVjf/2BWreP3Dl+RnNeDMwAKbmZqEuArsdVQU99YGH1VsDsyS0s4iD5koVfp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31C4C5E617C9F742A826A5DD8DCC726D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc41a153-7339-4526-0aeb-08d77f0ef2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 14:24:07.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4SRWuAvaUsNeDG/C5HsWwo4ZHt9FL7oEADJDzd8Q46MwQ8VtXZkVyQFZWx6Bd6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1903
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, 

On Thu, Dec 12, 2019 at 11:20:48AM +0000, Ard Biesheuvel wrote:
> On Thu, 12 Dec 2019 at 10:38, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This function can be used to transfer EFI status code to string
> > to improve the readability of debug log.
> >
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> I think I mentioned this the last time you sent this patch: by making
> this a static inline, those strings will be copied into each object
> file that uses this routine.
> Instead, please make it an ordinary function.
> 

Sorry for I just sent a old version patch. I will send a new one.

Thanks a lot!
Joey Lee 

> > ---
> >  include/linux/efi.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index d87acf62958e..08daf4cdd807 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -42,6 +42,32 @@
> >  #define EFI_ABORTED            (21 | (1UL << (BITS_PER_LONG-1)))
> >  #define EFI_SECURITY_VIOLATION (26 | (1UL << (BITS_PER_LONG-1)))
> >
> > +#define EFI_STATUS_STR(_status) \
> > +       case EFI_##_status: \
> > +               return "EFI_" __stringify(_status);
> > +
> > +static inline char *
> > +efi_status_to_str(unsigned long status)
> > +{
> > +       switch (status) {
> > +       EFI_STATUS_STR(SUCCESS)
> > +       EFI_STATUS_STR(LOAD_ERROR)
> > +       EFI_STATUS_STR(INVALID_PARAMETER)
> > +       EFI_STATUS_STR(UNSUPPORTED)
> > +       EFI_STATUS_STR(BAD_BUFFER_SIZE)
> > +       EFI_STATUS_STR(BUFFER_TOO_SMALL)
> > +       EFI_STATUS_STR(NOT_READY)
> > +       EFI_STATUS_STR(DEVICE_ERROR)
> > +       EFI_STATUS_STR(WRITE_PROTECTED)
> > +       EFI_STATUS_STR(OUT_OF_RESOURCES)
> > +       EFI_STATUS_STR(NOT_FOUND)
> > +       EFI_STATUS_STR(ABORTED)
> > +       EFI_STATUS_STR(SECURITY_VIOLATION)
> > +       }
> > +
> > +       return "";
> > +}
> > +
> >  typedef unsigned long efi_status_t;
> >  typedef u8 efi_bool_t;
> >  typedef u16 efi_char16_t;              /* UNICODE character */
> > --
> > 2.16.4
> >
