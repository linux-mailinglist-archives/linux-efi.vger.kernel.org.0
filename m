Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0484C46E2E3
	for <lists+linux-efi@lfdr.de>; Thu,  9 Dec 2021 08:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhLIHJO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Dec 2021 02:09:14 -0500
Received: from mail-bo1ind01olkn0148.outbound.protection.outlook.com ([104.47.101.148]:17184
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229919AbhLIHJO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Dec 2021 02:09:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqTlQloEouznbC4tk9B5hL561OF/R/4R926SERqlfelsIx44eAe8kfqwSrkzqhD5dPvgKWoEn19oro5mwlsPuVifFr7T2pBnjBuHwnyPPhOBXNVEBuepphOXj5QC8PNYvhza1bxbejF7lY1b1UWeBkY6jJo99VmHFv5A0qXkUN4EBC356wynwYeFeI0QiuoEVtnrs/OYsDjcg9VLRTB1ZWGM59NqniWi51cSgA+KvJeMI83euw+uttV27efOvfOEU43TwvKFSQC+kihCfiVrZFwSmxY0wugHbDANs2vjiuLHeFqkofw/k3a1q1mYoSPTa2NRKvDoRQrF1vf2WqBbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2TDJIl9CP3/J6oJzk5/m3ddink8nTqKkfpBqBubpWk=;
 b=m/fWARppc5uxugWSgJs2lyVU72sDOYuMzmPliFiiO8ufvjciSUloAvkcfrUY2QGduhGp5uxfSNHltU8iPI2TvCLDbSEcehQYBLD9HRwt4ctqRz33vemKBABWVV9sGUzjG/4lxHdYfWFnr2w0VRFdikjm7fqKDLaSyTawbOC1x/NptgYtKxCqoxbfmgvh/FqJgfjhurZWbWYg02h7gYT0cvcA2/OcGwgla1Fwvh9G165xG3ImP1VdCuWruIAu+Uju99WUSMBIZjWTerejPVuK5j2u1hc/UhQfsdlpoNjkusAZ5hQy0p7B3P/CzUVhfJcXpHNdbUXFUIfZxmga2LPUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2TDJIl9CP3/J6oJzk5/m3ddink8nTqKkfpBqBubpWk=;
 b=hdLzc8nx6y8rEBot6C2F7KcpIC4tQ7w+H4rTzOkXH/TadpPPfB4i7zk1/scYVnSP6u+XBEvEWvkE6DjfjKwB7nKSuB2XXqXBBYstC128ZpdPXHo+3Qmy66oVsK9qHvAdw0vsFR6FIFBggG5qkN+VPv5BvCdHG1fAX1gYBQxLvY0n/YQf2ODSxiGHc7onKWBOOZTABj97qiqRG7bRQOqbjgLmW/VycU/7dmJIOM9332F9/9W21EYRG1sjX/ft80LGUk5vOmsmX+Pzm+NKD1i6jXk7c3nfeVLHjdGtrEMGUx5CRRDYDZrrQ7Kp/XHBjLVzj/1g+gGbJyzbVhSOsALSyg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNXPR01MB7042.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:05:35 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 07:05:35 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [BUG] Enabling EFI runtime services causes panics in the T2 security
 chip on Macs equipped with it.
Thread-Topic: [BUG] Enabling EFI runtime services causes panics in the T2
 security chip on Macs equipped with it.
Thread-Index: AQHX7MspcYEsfKMkhUG2N0HFZhE8EQ==
Date:   Thu, 9 Dec 2021 07:05:35 +0000
Message-ID: <74ACDCF3-6996-4CB4-8899-A625D154FB0C@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4HnK895JPLOmKrZOJ5GQCVytjx7Cu5Fq7Z+pbe+rna84T+W1VfKybu8ToXK/+vmQ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4de51cd9-891c-4100-ea69-08d9bae24c1d
x-ms-traffictypediagnostic: PNXPR01MB7042:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC19JclL2N2MAwIpfTnDEkAfjzFNmwoto56SnVGlrEZdeleK//NcfuTDKMwRKQDJ+6n/o1ZT1iFrqOKdidQH1+loN/XtiGOel0sdYbnThIHseBaSQ51LjCe6msrdfw8lniw23z/WRqCZa1dJhOkIDaW+p7Jea/nehL2hjvjWkvmdypRkvm5o8VHmdatnd0J2AS66X5/0LUlLXcl4cI/xtGKd2ojxRhmXYvou9AerpnsNILz4FIXErdmphppVbV4LgAqyFyzm8FKmuQ5mm0uYHu7q0I65oEM/V9YuiVuR83ZllGklaAi8lT8GPqW28M0X9ovYs1A8f9UJGPwCN6QFkK+By6nPHd/v1KCP7cqVG8KW4MXHY6aakN8PctesLt3Rv6sY535fQJfrKRlGTbwge2ueYoU9TGy08jI4g1pfDEqMC7FoFMIAcGFGwRPw13hdEljeIeB+N/jfrfWiBwMwQc3Dgpd3IvBAyhbPEm60C2IoOhIhKseSQXHwRH4nB0TOpGbeDfEXBDAUGmaQB9QPZoLmz6vIKtTVIj37uDkSaLI/knqCyJzc3aLMh2jTCMAAr2af/df+z1lJfZevcFMvxEQBB0eS4AYyf2ggCNQ4+4OzWzcMM7oigifKEhNQlmTC
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UWwjIX/R1wSbduvdcmm3o/Dxgip0rTVAPLd0h0x803DKKPiS07dN4GVIU6AA?=
 =?us-ascii?Q?cAvVazPlJiH4HVN4a6gVmhdtIEMyNRPVUJv+tTCuPYXHo22V5mhaEmTe6t1W?=
 =?us-ascii?Q?6z3CtXmJmHavPSK/kBmlB0IDeTjpRoK7PEgbzOeTUdIbvX/GSusKGtgekmKu?=
 =?us-ascii?Q?qBico0fwfYmKpnhjeGmiLK1Hor+8d15V8XOW7ksMs9mueRIIu6OBOmaGQRoX?=
 =?us-ascii?Q?VteBuKhAoLronKf2L02JlnF8o07iYvUb5HMgiEw5HjCHvXeXNcncYOA9vPWM?=
 =?us-ascii?Q?Z7pCKSS2uX1skzekklhp+WFZp9DfS8E5kbwrGfenrxcLOpb3RXkOakvEb9q8?=
 =?us-ascii?Q?KWuSDd5//a5dlDk+Mr5dZv9Fnhj7DubRTQCh66wleRTZbV+YDMy3QIRECtPg?=
 =?us-ascii?Q?zRKk1qhODz7TT+xHJmlKv3jZOAYrRleVT2qXW5Ad4euKlomc71AjdKRz4N45?=
 =?us-ascii?Q?qtzAO7t1N4XwKHBe9PpehRp71qgknptzmb6ehEy8n3a/phH4O5iBLG83Bjug?=
 =?us-ascii?Q?Mz5LAbxaH4lhEwC3GJJEqa24mGNPAauxiviZ7O81LXuuseN1xLVYjtQL8bpd?=
 =?us-ascii?Q?BdBdQgDKQZmz2qc4vggjqZ1zUkObaEu51PtGBrG80ZgMk/LonVC2Nf4c0UVq?=
 =?us-ascii?Q?IZUsuzc4NHnOdKzkkR9ZjO1AKnhV8yZCsCN8IIUQsULuQyzSeYkfnmxVzj9l?=
 =?us-ascii?Q?ztq75MeZddpAyHqMiqWwA3YI/SvMd90+U6nMPIycZnD0lqszwFXu97G4rzGv?=
 =?us-ascii?Q?DE9K2TpjAp1wqgET78AdHF1VhWaICmOUU/BA9GUv07hLG0SHsUvW8uowqqDj?=
 =?us-ascii?Q?kV1j4mgKbWP20HNRz/pq2/vN/jKn6vFPZHL2C41us9gLZoCO7g4jTgF6MY9X?=
 =?us-ascii?Q?ELuYcVTRoKVsMUCyBeJsTf9IvwspcY1zkVgDP59Xf/+CGecIlnYDt043/AxF?=
 =?us-ascii?Q?BZLqESGxntYcy/oULUejU2ykgRTtsuNVV6KLwmbRBOOJ7jxrN2MXZmqaRwjQ?=
 =?us-ascii?Q?FJZCTqn47ZUrXm/HZAJInfrlwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F72F7B8167252498ED7C7A1865CCBF4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de51cd9-891c-4100-ea69-08d9bae24c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 07:05:35.1492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7042
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On enabling EFI runtime services on Macs with the T2 security chip, kernel =
fails to boot due panics in the T2 security chip. Using efi=3Dnoruntine (or=
 noefi) as a kernel parameter seems to fix the issue. Also, making NVRAM re=
ad-only makes kernels boot. A fix for that would be appreciated.

Link :- https://bugzilla.kernel.org/show_bug.cgi?id=3D215277=
