Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD248A87C
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 08:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348535AbiAKHf5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 02:35:57 -0500
Received: from mail-bo1ind01olkn0152.outbound.protection.outlook.com ([104.47.101.152]:64727
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235399AbiAKHf4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 02:35:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxoWgyunktY+C1duBh6d8puB5IAmj3B5HTpuAptmNZ+yXZJQHvYr2fWp1X8hvubRq84iIvQxVMk7UtpKXnckI2kruh6Ed46mfs4VpyG8iDzTq6EVUAXJMeSUoRarxRlJKv54MndLuClfQYR5Kk5H6zUh81KG2v6PkJ5p3ljjuMA16IpFy0+e76gxztD7IQnf4S2saBDeF74y26gVDkfmP02k15izfyRQws1IgEcqBFOscR1W8/1OREVe1LNpgzmF7cjIk8Zh86Dt/skH4uwUSQWMSmkf3c6S2nPC7wv5Mcx2m/s8ONw3ZjsoDIkVSzO7rxAKnRa5iXULSSavjVfY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0tjhTlxMIk04j8Aj18DgAV+Gm5ZBzmFXzlvo6NhwNI=;
 b=KdxzYYqnzL/+K4PlemhiGSbuuqef+lysUFro71sdxD6SD0PWPqE7h3WnF4Gpl9ZlNKAnqxxscgUJvsdleyz8VGGBalSd47hTnPY02dZ018+8TJKe7Vs2aXtJrFAvOkc0q5uRXbTR4tBYYzAP7gMShIDAw65+UeLdYDxggc8YX8l8U4x6Znx9l4MATS2eQrLL582RGaXqPs8Tn1aBJDWl4r2SFvXS1NFTJhtHNGDoFi+BZekHAuibKBdnRfPhQML+AJXVNomMVgq57olvPzzIOBtE1KcpxGBo1Go1Z3k3CobFaA7C7+uokofNF1rKnXCck2XbHxDNoiEdRK8uVkh10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0tjhTlxMIk04j8Aj18DgAV+Gm5ZBzmFXzlvo6NhwNI=;
 b=KG+G6fB5cBNX9IMsY4h7P4ggZCV/0BZEMvtZpTJ7jqnsd9X8Y/cvvydaisaGYv54/+hG1kYqtiCVgeShz6/EljvwbJOPDE/i/AUc/LQxLOqAjMxjIflUbqMUZhORrd4kEA2cBTvxoXeFNHQRvi3LD0DCiPuHYgl2gY0VDAydblM5i79HQuaao9rEpU1nORRYvP7uzueAm3YBNJgLkoO8IbF2qesJZratBmisqNwhig8n/PRS5Z9GbVgWCruDejEuqMxOpWJf5P41H6XKosbZmu1H0LAhuCHxIBUxT73vOGFTkM5It9HH78sYWUGWx29waZjzBmStvuXf2Ofpv8He5A==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB6627.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:87::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:35:52 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:35:52 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Topic: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Index: AQHYBjftpMq4zkRpy0ySdpCXbzTJeKxcamkAgAAHMYCAAALOgIAAEuaAgADBTACAACaqgA==
Date:   Tue, 11 Jan 2022 07:35:52 +0000
Message-ID: <1DA0C4D6-F14D-4342-9533-A50ED1DD4BDF@live.com>
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com>
 <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
 <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
 <20220111051717.25b86946@localhost>
In-Reply-To: <20220111051717.25b86946@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [brCJ12Xo7iEYBA7fTA3WbPha7FHFhJ70Y7OtgL5Zb+kE3t3gFsnPnd1uHfXte0kQ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c911668-2212-4e9f-f6fc-08d9d4d4fef4
x-ms-traffictypediagnostic: PN3PR01MB6627:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLPhkz6hc3iuri2OY1QIZjEuKcbQvkstCNOOTUW/lEDdjBGilcgw4N5NRv59/9x7tTTIinWXfjHMSaGx9oPNHwoYegWXKe/3YonCMgQZI/4gCdUhwRoNBUC9HpUAmabIUhg4Nu1rFY+H38AFBQl4C0ak0ThF0ImH/Za3j+WS2XpdggKgK7v8RzyST87HlrGMKRKNOxLb/BUQJJGlzRpdNTTg07wj2sYlc+EMK3nfvzGiaIN8kzFA6hbYREII+KniKvLikaBAvNPP5uTa+ujz9CtTzb2vMbfVdi+DuPN5hVfUkWbn8TDsxeTTgb72FcY9dOlrzyTZLaDzVPTLM1GUUcZKckYcSWm9OpN2eu+5nJkU00XVyElJVn1rwsEzj1RGPWxzNToZ8VGcXe9RzpTywiple814YFhPfNP5FFkhq947raAv2LWEQzUmUM7AjqDHWm3V0CEH8nmLDOU5zriQkapRO2lcg8FZnOTEV2oJhgP8qbZIZEBh5KyKhpslxpd+ch7K5/xdLBwNl09TcilVDXYn/bMdaG0qi62YgcTqGe1K1ua1NPLDOtVM6450+Fz04crGueHoYhcB9IQxjUFNUw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rtfhy/tSg1SmQMvGMC24jkVTYSlZIaTQeVRxZygRXQ0/eDDTutql3kbD3KPi?=
 =?us-ascii?Q?xyn/XeUhsktrFMjTI+ycN1j+lyo571PKqew7ED0qFCGd6IPwmVUxLEAVAJR3?=
 =?us-ascii?Q?EZAV4mJP4zUNDDtXuG688jcbQnPPg+SDi7JmnJ/oindZP7FFfK4FZdPqM8Qa?=
 =?us-ascii?Q?VxJSbqN7o19qY5+FZMAdX3cwVm81hm2gVCKK4uVGf4y8LBYV7WeLgUfvonTh?=
 =?us-ascii?Q?0mweBnZ/74OKtQ2gdNgBm+vRX8z6FqosDMr8yF9VGcUa09lXQxiCOagPpfZk?=
 =?us-ascii?Q?sK58W5oHlpQ0TH/rdkq9vugPGgNDhTTDPWWSAgnAUJDcEt6ccfS8KVO3/OPH?=
 =?us-ascii?Q?LWKVGvngx7CPBYmB5nyCwbAXxd0LNhCrUvZhYRtBqL5Ok20blEMGVsYij2Va?=
 =?us-ascii?Q?4Kyqxi3aQzsFWBgKV+TSBniTNHNgjpE12Txt0NWCqfv0RVmnUL42CPIBo22p?=
 =?us-ascii?Q?nUcc2Qst77iDJxvXJzNBOehC9bNxl3GZO6mP6367Fw2OmXKgqUmFslx0E52p?=
 =?us-ascii?Q?LVQ+4dezIyy6c+UZtakdsavwtUQW3NKmPgCkGBYnVVjTWuBiT9iS5eGXhHt8?=
 =?us-ascii?Q?bHdBfnJCDBaPLEVPOKizLTWTBxVeeQCTu9NdVk0noO44kJwcAVZK5uW4e83/?=
 =?us-ascii?Q?B9lcmcAssTVuNrFJ5ggLmc0ZA+g5jsl2psvx8b1doNsQqOAJ2nLKUXZ+NE8K?=
 =?us-ascii?Q?SM0Z0r5Ll5L6IiYOu4A2e17BcczWJyLL5Gmy+QwwPYTlLdwB6abPymenlG5T?=
 =?us-ascii?Q?PQ+sx/L9wvMvU1Y8OlgpG1n5Ska68w7HPP8o6Ut6oOTkI9AhKGanFliuGGbf?=
 =?us-ascii?Q?WVaMhpAXPfhiyccV20o0mIGeIVDCx8W+1hKkiIFbQ5VJrPkGpAyqcEbl2B6E?=
 =?us-ascii?Q?YPqfbCAikTSw1NFBypXRg3ue+lKxrq/7xAmxOn6wN8Q6JkYavGhGLIVVVN2h?=
 =?us-ascii?Q?F4NRVLZLCiJmHmnCq2T0mOzZb7SJKd94d5WRUP0pb6nSm8DiY3pQEM3agR4S?=
 =?us-ascii?Q?bMY1Gun1ydI1eFY/1ohifbRM9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <789EF56D7B52F041801C79B4C319DA59@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c911668-2212-4e9f-f6fc-08d9d4d4fef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 07:35:52.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6627
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On 11-Jan-2022, at 10:47 AM, Orlando Chamberlain <redecorating@protonmail=
.com> wrote:
>=20
> On Tue, 11 Jan 2022 04:45:35 +1100
> "Ard Biesheuvel" <ardb@kernel.org> wrote:
>=20
>> On Mon, 10 Jan 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>=20
>>> On Mon, 10 Jan 2022 at 17:28, Aditya Garg <gargaditya08@live.com>
>>> wrote: =20
>> ...
>>>>>>=20
>>>>>> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
>>>>>>=20
>>>>>=20
>>>>> This is interesting. QueryVariableInfo() was introduced in EFI
>>>>> 2.00, and for a very long time, Intel MACs would claim to
>>>>> implement EFI 1.10 only. This means Linux would never attempt
>>>>> to use QueryVariableInfo() on such platforms.
>>>>>=20
>>>>> Can you please check your boot log which revision it claims to
>>>>> implement now?
>>>>>=20
>>>>> Mine says
>>>>>=20
>>>>> efi: EFI v1.10 by Apple =20
>>>>=20
>>>> Mine says
>>>>=20
>>>> efi: EFI v2.40 by Apple
>>>>=20
>>=20
>> Can you check whether things work as before after applying the change
>> below?
>>=20
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 147c30a81f15..d7203355cc69 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long
>> phys) efi_nr_tables           =3D systab32->nr_tables;
>>        }
>>=20
>> -       efi.runtime_version =3D hdr->revision;
>> +       efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
>>=20
>>        efi_systab_report_header(hdr, efi_fw_vendor);
>>        early_memunmap(p, size);
>=20
> This patch works for me, I was able to use `efibootmgr -t 2` without
> panics and the change to the boot timeout value persisted after a
> reboot. (I don't think the Apple firmware would actually use this
> timeout value for a timeout time, but it is an nvram vairable that i
> was able to write to)
>=20
> efi: EFI v2.40 by Apple
> efi: ACPI=3D0x7affe000 ACPI 2.0=3D0x7affe014 SMBIOS=3D0x7aed0000 SMBIOS 3=
.0=3D0x7aece000=20
> SMBIOS 3.1.1 present.
> DMI: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 1715.60.5.0.0 (=
iBridge: 19.16.10647.0.0,0) 11/16/2021
>=20
> ("iBridge" might be something to use for a quirk, as it should cover
> all Macs with the T2 chip)
Ard said that Intel Macs have been implementing EFI 1.10 for a long time. I=
f we want to implement the same for T2 Macs too, which claim to use EFI 2.4=
0, maybe we could force implement the same for all Apple Macs? The M1 and l=
ater shall use arm so shouldn't be affected. The T2 Macs probably are the l=
ast Intel Macs.
>=20
>=20
> --=20
>=20

