Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAE48A870
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 08:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiAKHcf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 02:32:35 -0500
Received: from mail-ma1ind01olkn0165.outbound.protection.outlook.com ([104.47.100.165]:5015
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234173AbiAKHcf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 02:32:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW5mwUlITM9xVJCWkSVZJRKThaEFhV/5E3et7Q9iUk65b/sBEMPXla7bH2hEZ+FNvuWWD8DbnyD6v55BPwA537Qbie36yzaUQ/s6/moMX4DRIWg+cgb3Pk/h4VOtFlYJOZukZPmgF+ERhhj8gt53ELftnpvAaGhu9G2zK8RhsYo0nRx/9DQGGPXdA54eg41EK49b4yidOy7bo62oY6+0lpzy0IpJ5EE0omkOvzBv75aEdjXHFsdxd21/UeYANl4vcaCsQaULNvlLqN9dJsQF513NkoYovIjoaJm5KpPDFy0OHXiNZP9yiJoq8EbTVyTYUcmf3ylUQ0pfRtDAfka9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/LDNiYuxJtDqXH6FCQ0z0DueNW/syBSvkozLLBLdOg=;
 b=LxR2JuFoACJzJuIHxP4T6uOtK72/a0LL1KtnBxtVu9Leoo41NjX12j9QLqEEwZw1lOKeAK30RyO1kCQIsn/rUIsW3128AkX5/5pTZo06mzANyVMAhfKqr19A44IgeYUoH8cDasWdFg0DWRBZ8qNIzbtqYbIizE+hxriFOeE/Ywrqw2nwi1dnidDDroACd32N+FNP4evw7kd9ACvJcxsG2DMhuosZlOyC1wE9ROqY6zKRxJ/C7CBRe9CA5voPjL0Bd5/MXGoqFSmxVWoujPwpZJlx3J6Yo4oSDodI5G5EBtIQH/6Mdi9wCgN2ok6ERuxKyaizFhNY+t67CjPyjAM4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/LDNiYuxJtDqXH6FCQ0z0DueNW/syBSvkozLLBLdOg=;
 b=shkXbJf87MiY9UrDBg1ooAcW8/kjhZJmxkGQPYW+imqONta2Itd3ZxLBYTzVv8yPlPAiMOUaluQd1YRaH6qw0jMZq7JMKDgIZyuE1+dG+2NEQDGCdpI6Iv5QJ/Um8/ZDLmJ0Q/9QXATQ4rW5PwiBaW3nsDwNCzgBQly9v1HhBu3Lqu5sg6Yz3S2GRYtlWjhLsnnFBD7iVcyK07jRWB5yh0BqaHwDCfKC/+cuhcUN+bzHqD1SbVu3/XeLavHMHb7+ROS/9YfzpE0HsSTLIymrOuOVm5Yv+/qT+Nygyv/itBeWQJAIDHz3fWmI+d1qFDwc7eeow6U6/i3BsbLFFxglfA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4298.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 07:32:29 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:32:29 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Topic: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
Thread-Index: AQHYBjftpMq4zkRpy0ySdpCXbzTJeKxcamkAgAAHMYCAAALOgIAAEuaAgADnA4A=
Date:   Tue, 11 Jan 2022 07:32:29 +0000
Message-ID: <6DA95E5A-E36D-4EED-BFB4-6EB36D541941@live.com>
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com>
 <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
 <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
In-Reply-To: <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4dPly84Jjmy4JRJ7Mskd9Ty0b2ZUG8O/POI+Fq3tfpmHJMxoxyVFlj7K4BaCylJy]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076cdbcd-7f36-45de-c7b0-08d9d4d485d1
x-ms-traffictypediagnostic: PN2PR01MB4298:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okkLlxJN2ckh9hKvOM2S2c88PL/5YmAUKoK9DvfgWidmKHl6cEM/Ji3ZIk0X3eHA0vcoVd6EtqzVC1baIPLk7AYsidsWfLq4lli4xItc+Jx9zXpSCPtRqZ+eM4RNYBOfw7Sm5D+ELGTRNWr1r4SH40LFxnmXyoQ1eNUgNholjVrbf4cDEeJIwgdtoGM+n/JUIIyotR4nHuWt7Z0LvtnLBh3RZ1bOCt36gd5tTp3NwIFEyQcsbnDIXNdKzM91kNIq4m8XlB3DCz0iIutdUt/EtDNxmyd/hip50pbGhiYy5iYNfld26xB2k/p5EOOxhrqh8nvwbFAXkFrsF0+VDNWkpfwtsCvaQ9aA0bYYOD8vHZwfz4H6FZ/+YLzKKw26gCc8rjcsRf89iSOPMdl3S9Qvs065NQ4/z9BX5+bDdCin7iyddmuLdccNVbVojg/Prp2uL+KJr4CyvgmjEUtIEdc2zFWR5bUIGTRdHjvcyiPV91o3+kNRiyt/pJRR1Yziz1i2m1fn8pck6+o32JUBHQj9zG+43t9MiW8VhCtig+2lxs4SIUFEhevE3YD7wYJbjtRSciu1RC0p+lH4TU3pD6ynlw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvSo/Krq/nR+TuSCLrfqOHmXi6qG1+LK46Joe3jetEB8phb53MrXscbNddoi?=
 =?us-ascii?Q?q/FeXMAeJLU4K1Etgq5D6uH5xp5pW20MV7cAVfxyzeMJfvYhxWE3ww0s7NjR?=
 =?us-ascii?Q?LxCLWHYS2E/qgIixL6nih8TD6ATs3X/yO8zZQxqhBdfcdhnr4etKpdv5YDtR?=
 =?us-ascii?Q?M0HJTZT5h6r3MGWQ77KSTZAzSrDRR6Bo6h8wuJDa7/kWxF2flUd+Bpiu2uWQ?=
 =?us-ascii?Q?/9wm1l6buXboi/TVlsxZXSKrJkoeIntM6KoDqARAbyfOGDMYwMVi5XH7HGNq?=
 =?us-ascii?Q?6adl7CXn66+hJtQzq7JkioIFubqV7vLN1cac78zAIuvUG3+yEcEv4wMT12AW?=
 =?us-ascii?Q?XQnCPuJJM90Dc5f7eFphKtQl6INO4MO3KyWRw5VTYWvcjk660g6ZbKE6049A?=
 =?us-ascii?Q?1JPA2/F6RASh/aLMwf9VcAmsVDvV9Vl1T3WmoSUT7HgzJJlnJGqN/OZoWAL5?=
 =?us-ascii?Q?2flUq7yC23C3608NoamS8AYd4iOar1LYQ5GFCltpKhWh6eP9zhMAd0xCOGKv?=
 =?us-ascii?Q?epVrUSAoUBZSbyQUlwF+SBetuC+d2ZgQ2dNdq86NgBGCQ29v359vJ5nzJr8f?=
 =?us-ascii?Q?zVeFVSlZqW5CO495/UCixvdFY2qbkSq8/2MWtMlVPqct2HQxKnVOJ6Y5GpPh?=
 =?us-ascii?Q?loRsfswDBYgWiDADr3Te6Gx2bC0pw1eJVCqyNDBRCyfR8GKxczKJ08P2vN04?=
 =?us-ascii?Q?zWHYKmRxgYGqKFxpjFccAUSePiy3bRfG6UHLa4buIEJT3kpaV7DFb4Pd+F8y?=
 =?us-ascii?Q?EFzm4cBb+Tf6Uil/LifdRaYJjqkwskIteJXerDqDcsQ24yFZARNrWXsH2EEG?=
 =?us-ascii?Q?7yQZspvm/teqKejCJbxr+H8F/U8Q8tVfoip0zBTrlNNo8OyMsFkP8sIn96n5?=
 =?us-ascii?Q?r+iODDAqOe8KrEYKfcdfjtgJKqBn6HfibwPjqvmteQ0GAVFZN0IEsaADOW+y?=
 =?us-ascii?Q?Y1gZTBmIoVjMpCp+1M4kUxMN81WckdTRIXcr1D3VCc09v1gdsu+C+dKRPTmf?=
 =?us-ascii?Q?kjxMdD/iMwScUrqj47C7iqplFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <339FF51673741C4E96C0ADC17EFA4106@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 076cdbcd-7f36-45de-c7b0-08d9d4d485d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 07:32:29.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4298
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On 10-Jan-2022, at 11:15 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Mon, 10 Jan 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>>=20
>> On Mon, 10 Jan 2022 at 17:28, Aditya Garg <gargaditya08@live.com> wrote:
> ...
>>>>>=20
>>>>> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
>>>>>=20
>>>>=20
>>>> This is interesting. QueryVariableInfo() was introduced in EFI 2.00,
>>>> and for a very long time, Intel MACs would claim to implement EFI 1.10
>>>> only. This means Linux would never attempt to use QueryVariableInfo()
>>>> on such platforms.
>>>>=20
>>>> Can you please check your boot log which revision it claims to impleme=
nt now?
>>>>=20
>>>> Mine says
>>>>=20
>>>> efi: EFI v1.10 by Apple
>>>=20
>>> Mine says
>>>=20
>>> efi: EFI v2.40 by Apple
>>>=20
>=20
> Can you check whether things work as before after applying the change bel=
ow?
Patch works for me Ard :)
I am able to boot without efi=3Dnorumtime now.
>=20
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 147c30a81f15..d7203355cc69 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long phys)
>                efi_nr_tables           =3D systab32->nr_tables;
>        }
>=20
> -       efi.runtime_version =3D hdr->revision;
> +       efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
>=20
>        efi_systab_report_header(hdr, efi_fw_vendor);
>        early_memunmap(p, size);

