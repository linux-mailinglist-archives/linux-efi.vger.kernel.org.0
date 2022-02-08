Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58984ADBB3
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378622AbiBHOzT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 09:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbiBHOzS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 09:55:18 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2040.outbound.protection.outlook.com [40.92.103.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49FC061579;
        Tue,  8 Feb 2022 06:55:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/RaUpfE+i6cLfq1zRwScRhO5byBr+oRsoyUL/n5aiKx9G/kjRwWSIsSF0HxrdYfaQXOvvLjWcqJo8KuCFQh1Lt7y2ih0REgk+9iyNqMcYWA3J8ej2EBqBN/tjNzl0X6Ja9S5B/+ZVUViBd+cczAQe2VcrucQ8jfMVZZdHF82zqc3gLEwJznuwxXOxkCrOZu0XCkZRwgjKqk+kkL9nb4x+g+0bzwnQi5FGyEUjWTUF2W/96QeAGJotCoK+8DYbcmWCc762x41BfwP4kpRwRRND63E+NfdNH4mnXYKpp9N10xwSsIGB4Rz1oQpCAer9QWt9+ShZeocKyEeKou5Twtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUtTusyOT4md75lry1P1HozY6Mx/2UJg5nQjOAuY/3Y=;
 b=B0YIz8RZ9ljc2UVjyeexCtHECPF08Yxh7jfSTmI7fLPXKicOKGuJT/77yJLRUDKlsoPyesXfVn04tEKV0/HUW1WrZcvZT1NFxo90UfuJqTzWw2qnTtV2Fo6PkSyIc15LopMPaTtr/TlQgOym0ATcFJAxZp+VH8evvi7X4HNgSfr/IM04mm3+NBbS/jTiVrjK6IEOgUb11F2q2JTi7ddV3rGJKQ03MqkPgKE7mjx6iE2huoqlbJrOqvvoZlZnMOCTzNdjeDW0FgZA7R4p6u4tknaMtaCRuvP/fpvIjofAEzHsM3q9vMntU8lGK25XqX6sgrwfyzOHNdXYwb9j4mXtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUtTusyOT4md75lry1P1HozY6Mx/2UJg5nQjOAuY/3Y=;
 b=unejyP3mhe05eN4d3HTv6HR3GzR+WHbwGckOGiYzJRzml6jjVvX7pOog/ThRs7rk8hoh0O0bK9d6Tn3zWT30SDlNc+j2pVJzkUXanU6Im4mqN1tmA5hZe4mgv179rr2KjTh9OTcsGXix8Hj0kFcYKs1FmiJgHWXWopN137EX+do5SH0BTcN1qbI4L82edHGT3U3IN/mOiaxUkbt7RNYb5bPUDKxTcA2wxZA5If8x9T2NTlHU6slnje1lWw8ZlIYmYTnwYiVsi7nurQT5MFXwapzCK+DX0dKTrmXfOb7XiaCyMyDrXsmzNqffWy0mN5XY78J1Hh9isGPlHbzsXFBIOA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BMXPR01MB4759.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:55:12 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:55:12 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG SEVERE] Failure to enable EFI Runtime services on T2 Macs
Thread-Topic: [BUG SEVERE] Failure to enable EFI Runtime services on T2 Macs
Thread-Index: AQHYHPN9yWRx6QwxHkme7awzoxWFeKyJr1oAgAAOewA=
Date:   Tue, 8 Feb 2022 14:55:12 +0000
Message-ID: <2A5B5047-23DE-4660-9ABD-446EE264CC54@live.com>
References: <E5DB4C43-F2AB-412A-9891-C13255374AD9@live.com>
 <CAMj1kXEUudnnX8FaAhtUmcKB+jt237BUTsMrNC8ZoOepf4P3pQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEUudnnX8FaAhtUmcKB+jt237BUTsMrNC8ZoOepf4P3pQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2Mj+BrPDiwCh14Icn7nf1NO6WYuyCFAe/LSDpc49abQHuVX2DeKhnIeAJioc0lRP]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08714fdb-5138-45ec-4fdc-08d9eb130250
x-ms-traffictypediagnostic: BMXPR01MB4759:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1qfulWiPOoeYNxOIXS3awvfT+1HlWNqb5DVZuTdVuVfHGbUQoBlEF8d23QcuLPmuoTjxZZC2d+0fPu/QFHm4SzQTqdYhbe0aatrmS2URRASVMQyJ8RYK6UOB9rc4K/veScS9hR26fMf1iZYzFmkd9D3ZCd8fXH8PewDwzvyLT4c2h9Tc5yaVkBL6fx+HXhpEOJ6aJCbRn6M7UWTqJZQpssbBNQQpMpJubmnZABuTqB5USsX+MsCQ4KBoqcnPJYSO7vGH/mF1cQODCHEt1UWsUBc5BQJ9U2z1ZE3krIyjh2Bw1ooGF5mp5T5B3IbjmLaCAA4Oa8I16VOQzMd0ngKpGEtTUisxbouJPhL9LDiisuNRShlqXvzHtBLtpwZpkmurGdRN7EaPhkRwA1rMoKynpGGpcR2//LXgyOp8gpcINQ+iVk+6lsr0Jc0otgaZ6LuS1UOocB0MmOA0Hj+lacS8tqUaBww3up/gY6RtMiOUKGaafLNyK3O9goI/JHspDSv+NujBC5TXKGxDslhDnGb8WxdVuQh7optcpzIE/k2bacyxt+WTyJwQ7TM9hdEz/L1SEuqhv8E0FdYtW9DTKWX3r+VC2JwybHNP9c56Q4o3/r3kyW9e7eqdMATQqkfhfKIm9u+FoSderMa2UGi4jzrz7TE95dd52+s+YqX5jovsLU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xz+tAYMh6cVFspX/EZyRwi96O5a9RTNFlWfc5uXnSmy+g59IM2Gk+mikYKW0?=
 =?us-ascii?Q?LnYDoSWu+STTU2+qayTRdwTgRMfkyviR8rsq8bdyUflpiMyS1zfAZNyBw53Z?=
 =?us-ascii?Q?TThvdzwHXHewvOXovE71iaEXYnaWAG4gdW8ApZ1TT1nbwg9Blbb4XyhYgglF?=
 =?us-ascii?Q?Z868G7h6duY+SVXaBur4mTkpZX6A6C/Mh8RILnNpD61ZO+unG8/XrDwQ5lfx?=
 =?us-ascii?Q?c0C+VgwAZ5+kqZpMnLIg1QfwQUDYCa+ICjW7Vq2gc5Iz8dileR4zTY79kgcQ?=
 =?us-ascii?Q?yY0zc5RXA1lYTVYew16I+XUg7hQ6ttkuA/+KQ5gndlnS1D6YTi9hWju0VmdC?=
 =?us-ascii?Q?8u5kHCigSY77brCJhJPF8wE9+64xDqrcllGXClHAs8J/80/0EBUR8esPRNbb?=
 =?us-ascii?Q?sKS7JdqoagUNgQPecTs276Ff4zlx5Q7D6mU0o06xlM66AEGZCe6CIjz3GKDK?=
 =?us-ascii?Q?3Dsh/PrwH9RHhvG7ANgCa6rP8h1mDjjibCMGVVeTpjdRn8ucoccPj9AvYZCM?=
 =?us-ascii?Q?bERxCVDUvRj3A8j8h35//t2DFrJTDwzFu5AYCPvRYZpNDsY2D4PorfHnWhlO?=
 =?us-ascii?Q?BKiw09y1qU0Wuxj8/BAdV3HkJ9amjiRcdN+cYZYQcgKmGYmKlViALQBO1OGg?=
 =?us-ascii?Q?M5bB7pUCL6L57EaYU1bgB14z1VEEifyPvDxkk5jzM18qu+1t3kxKkLjQdlAc?=
 =?us-ascii?Q?EET5u/5seVKRo82z02r2MZzPCRgBc/nbisBgcPD0CvoTzRYporaDqoLjifqy?=
 =?us-ascii?Q?o/wLqpUoRT/3EoEmSEmjmScgT/QkPnorH197XUMUSm4ilp9BlQDkxC5u4imS?=
 =?us-ascii?Q?22bosdfSj1L0pOpGNYtW0I/oRL+1OHrBhgHqrTnPDpzVTyRqahKHYvAgWJp5?=
 =?us-ascii?Q?CRxD+02CBRV7+6VHE5nMKNgQqGBz9/hlDX5MsE2IR0KIrAhn3xV3cGEJzuyW?=
 =?us-ascii?Q?xEe48bLEVsBwscCW/aGcIqjOIidlZH9HrjimWEmQ7VMJO2JUI/8WTVN21h9g?=
 =?us-ascii?Q?2b4CUrAcJnwgwPzX9Nq/Ul+M2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D236C2EBE10B1346A17B09B513A1DBEA@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 08714fdb-5138-45ec-4fdc-08d9eb130250
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 14:55:12.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB4759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On 08-Feb-2022, at 7:33 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Tue, 8 Feb 2022 at 14:55, Aditya Garg <gargaditya08@live.com> wrote:
>>=20
>> On using some specific kernel configuration, on Macs with the T2 Securit=
y chip, EFI Runtime services fail to start. Some logs which may be useful a=
re as follows :-
>>=20
>> Feb 08 17:11:11 MacBook kernel: [Firmware Bug]: Page fault caused by fir=
mware at PA: 0xffffa79840068000
>> Feb 08 17:11:11 MacBook kernel: WARNING: CPU: 11 PID: 150 at arch/x86/pl=
atform/efi/quirks.c:735 efi_crash_gracefully_on_page_fault+0x50/0xd0
>=20
> This means the firmware is broken. There is very little we can do
> about this beyond disabling EFI runtime services entirely on such
> systems.
>=20
> ...
>=20
>> The kernel configuration where this bug is seen is on https://github.com=
/t2linux/T2-Ubuntu-Kernel/blob/Mainline/templates/default-config
>>=20
>> I had an old kernel configuration, where I did not face this issue and w=
as easily able to write to the NVRAM. That kernel configuration is on https=
://github.com/t2linux/T2-Ubuntu-Kernel/blob/b5c20b8c7689251dd943e22dbe02cef=
9020db8d1/templates/default-config
>>=20
>> I believe these lines in the kernel config, which are present in the for=
mer but absent in the latter are causing the issue :-
>>=20
> ...
>=20
>> Especially CONFIG_LOAD_UEFI_KEYS=3Dy is which I guess may be the culprit=
.
>>=20
>=20
> Yes, that seems likely.
>=20
>> I request you to reply to my issue as soon as possible
>>=20
>=20
> Please stop demanding attention like this, even though it is thinly
> veiled as courteous.
>=20
> If you want to run bleeding edge kernels on non-standard EFI hardware,
> you have to be able to sort yourself out to some extent. I am the
> EFI-on-Linux maintainer, but that doesn't mean I work for you and have
> to be on call to fix your problems.

Looks like I offended you. Heartiest apologies for that. I guess being from=
 a non English background my works had a negative effect on you. My intenti=
on was just to get help, not complain.

Regards
Aditya

