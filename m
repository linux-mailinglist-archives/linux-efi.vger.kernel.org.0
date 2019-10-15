Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5269D6F7A
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJOGOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 02:14:38 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:41526
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfJOGOh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 02:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ElSztWy8HoeKBZ3Iou+mBNrep4Cm/Vw01ON2QjT7K0=;
 b=1L1yuwdbxvH2Wa5lsVeTmwbe0+5GY3OZBUXNKVwgQU0AIsuYVgLIAVq2ftgaxh5i+FVElpYTQ5zGikUvxqxnGYvvux63iMIpYod8PxkvlZfpzg+ULQdTLNDI/sREDS4C1WVRyEwuJxhUhoWndJ6oOniWRqtQChFE+YNnXVT81qk=
Received: from VI1PR0802CA0044.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::30) by DB8PR08MB4091.eurprd08.prod.outlook.com
 (2603:10a6:10:a2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 06:14:30 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR0802CA0044.outlook.office365.com
 (2603:10a6:800:a9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Tue, 15 Oct 2019 06:14:30 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 06:14:29 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Tue, 15 Oct 2019 06:14:26 +0000
X-CR-MTA-TID: 64aa7808
Received: from a8ef3841ec21.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1E2B7E45-E01F-4894-8176-E3AF16AFBCD1.1;
        Tue, 15 Oct 2019 06:14:21 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a8ef3841ec21.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 06:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCxz6DbpWgB5q8KY0sgmyqot5rjr5Nid3Tc8d/xjkzh+lkKoehqmfg4r/srZVzQ9IfCH0LwlUL8nj+8MmFgC3+gCOrbSNPDmaW5f2p2jQoHMEwXAykLr0VJma0QZI+pYAzpn67mosnlNJKcuQIpfG23dLeLc+WGXj56wxX2V9Aep7DcUMVVkLW6kflKWcvdEz5wGP7Au/pNLoBVJx/W5tQfcoVNSpQN+UCVqf+70IM8GLzXkZU834YVfejytVp3LIlzaqIaxlmG8IIT0pPxqZ3KdRl4/LdnIYCn0BWH7WrBHwFdzTCR6I2SvJYOlusOMHMNJ74IYungB+XQuuPnr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p8k0fD7tESPMC1TW/+dQn6DRK0K4ngR3PhVATOaUxE=;
 b=lFhw2t1yZc50WqicowV029x0j+/WpGSJipteVtbB5IzHvblnbKRFLaQ5T02Ah4d4MdNzU7gwbcxICIW76vF9KSkSdRZwV+ZgZtFlSglBhSiiSum7LvL6J2vreNY+aF/XdLe3R0eFTdjT8nNNapJBWG3ZvQbZbR4BvmXbuh4CtihboK10SBpwpVT6yGzhW4XAk4vA2Ei9RoAQga59MGs2XpzR7h/dJxvB4v0SkffHula8eSUL+FYFRXRP1ltfavSs7e6AXdfRRoatNhGkjgAfQzWNQOG7Uc4Y5WUQMXFLyROcNvwT+SQVw87o2Ox2YV7owOgm3RaUBzUi+l3UQP3YnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p8k0fD7tESPMC1TW/+dQn6DRK0K4ngR3PhVATOaUxE=;
 b=bAz4s92Si6vbg085z3hQockJ2RgWZCMdSMIeXck1byf23Z15m3bjzGfMAQSXjkmi8Fpsj1KuB7leUmy3N7w8gNqMZKI/dfcu/MGd+Dt3RSijf3ODmRLrn3qFfJz/rogrBu5/CGjV94qhdkh3xQRHy1VXCQATTLn31BZzcDenOgc=
Received: from DBBPR08MB4678.eurprd08.prod.outlook.com (20.179.47.74) by
 DBBPR08MB4329.eurprd08.prod.outlook.com (20.179.41.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 06:14:20 +0000
Received: from DBBPR08MB4678.eurprd08.prod.outlook.com
 ([fe80::8d01:f525:8a77:b6da]) by DBBPR08MB4678.eurprd08.prod.outlook.com
 ([fe80::8d01:f525:8a77:b6da%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 06:14:20 +0000
From:   Guillaume Gardet <Guillaume.Gardet@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Chester Lin <clin@suse.com>
Subject: RE: [PATCH] efi: libstub/arm: account for firmware reserved memory at
 the base of RAM
Thread-Topic: [PATCH] efi: libstub/arm: account for firmware reserved memory
 at the base of RAM
Thread-Index: AQHVgq0Yhp6sEGyWAUeFiHCshOUvfadbOaqQ
Date:   Tue, 15 Oct 2019 06:14:20 +0000
Message-ID: <DBBPR08MB4678B3D2C238E362763D9FBB83930@DBBPR08MB4678.eurprd08.prod.outlook.com>
References: <20191014163309.2860-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20191014163309.2860-1-ard.biesheuvel@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: f91d3bb1-5188-4b09-af1e-759fbafa10c5.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Guillaume.Gardet@arm.com; 
x-originating-ip: [2a01:e0a:d7:1620:214f:eca3:b23c:22b0]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dd7dbe5e-f5df-42e7-3c67-08d75136f00e
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DBBPR08MB4329:|DB8PR08MB4091:
X-Microsoft-Antispam-PRVS: <DB8PR08MB40913BF09D12D3CE9EF24A2283930@DB8PR08MB4091.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(13464003)(189003)(199004)(71190400001)(71200400001)(478600001)(305945005)(86362001)(446003)(4326008)(81156014)(81166006)(6436002)(11346002)(256004)(8676002)(14444005)(102836004)(74316002)(476003)(5660300002)(14454004)(66476007)(66946007)(316002)(6246003)(486006)(6116002)(46003)(52536014)(66446008)(64756008)(66556008)(76116006)(110136005)(7736002)(9686003)(99286004)(7696005)(186003)(54906003)(33656002)(2501003)(76176011)(229853002)(53546011)(6506007)(2906002)(55016002)(8936002)(15650500001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4329;H:DBBPR08MB4678.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fol6dJKuj4RH9CMPpf7fgp9UAd8EpWE+srpUpDIW1zSzHbwmYWupxEn8iPUrj5a8xSorf2B0GIooKbJrD1bGW6hqwGSnIOgEGw+aKj9dtVI6kBdtUQh4JemAsMEoO1JMhtegVlrIRHEICBDrGY3GmC4/LS6C8CNN3ZzT4Lu52A26VZm09evwvwVQjzoaZ7bA/aHz0Ztw0oDC4Kee6oHCUkwr9VexFGflK/LVZCL8PtzDC1aeY9sLF32jBH9apAZxvh+arQsU1RrIlmveidAUAdj6eIrK4I4sHAt5y3s41yGQSWfXGl6oJpIfXDr1s1Uc/IYEnu8GmVDCiuAv9AoA7SW8hA5Wdkp0vreHOIy1zrEPianPvXMXjbemjBIky371he2JEi7lsNbZpwEs3Walgfm6XE63rMa6PTQb0uIQYho=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4329
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guillaume.Gardet@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(199004)(40434004)(13464003)(189003)(478600001)(76130400001)(26826003)(47776003)(22756006)(25786009)(97756001)(7736002)(356004)(74316002)(305945005)(46406003)(2906002)(50466002)(229853002)(8746002)(8936002)(81166006)(8676002)(70206006)(70586007)(81156014)(4326008)(6246003)(107886003)(9686003)(15650500001)(55016002)(99286004)(446003)(6116002)(36906005)(11346002)(63350400001)(5660300002)(476003)(76176011)(86362001)(7696005)(23726003)(316002)(336012)(52536014)(33656002)(2501003)(53546011)(486006)(6506007)(14454004)(110136005)(54906003)(102836004)(186003)(26005)(126002)(5024004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4091;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f6c7d96-4b0b-431f-5b71-08d75136eaa6
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdSpSVokMd1qa8LX8zP8uF7P0o9Mv4MDDkCdIharhBsO6G8GS8YUCaOUl6ksYUfTM5Mi1iVL4T2Qp011M+kh9vBLJ5OZhuLBkHxutwSJMZwxY4zbeq7p2BXtyOx2zgFF57Kb9qkiQJx9zDgfKUjCu77tgxyWPajHvPWPAj4lv9Pdrenp8uLih9oNZFkdP8PZEZ6QHWAPDmOVQC4BbxO6y9IWaDd8p+7QtlO+LJcvPUenna+WZnRKELI4OeZKs1SEM1vCU2/tuBcUEsmPtYv+c+rwfJ3bczbKDeFU8iszsWOD3GHyGy5/IuYDDSlw898zJUPnZmGI9c1EjujN4qIH0t5JmvXIp0nBdrd3rVVktJBwqbNAy1zOBGXHXdOfMj2SASM7cxGflj/Z7VcC39FMEB+MobzyIplzj08GYMsOOhw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 06:14:29.2692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7dbe5e-f5df-42e7-3c67-08d75136f00e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4091
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Sent: 14 October 2019 18:33
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-efi@vger.kernel.org; Ard Biesheuvel <ard.biesheuvel@linaro.org>=
;
> Guillaume Gardet <Guillaume.Gardet@arm.com>; Chester Lin <clin@suse.com>
> Subject: [PATCH] efi: libstub/arm: account for firmware reserved memory a=
t the
> base of RAM
>
> The EFI stubloader for ARM starts out by allocating a 32 MB window at the=
 base of
> RAM, in order to ensure that the decompressor (which blindly copies the
> uncompressed kernel into that window) does not overwrite other allocation=
s
> that are made while running in the context of the EFI firmware.
>
> In some cases, (e.g., U-Boot running on the Raspberry Pi 2), this is caus=
ing boot
> failures because this initial allocation conflicts with a page of reserve=
d memory at
> the base of RAM that contains the SMP spin tables and other pieces of fir=
mware
> data and which was put there by the bootloader under the assumption that =
the
> TEXT_OFFSET window right below the kernel is only used partially during e=
arly
> boot, and will be left alone once the memory reservations are processed a=
nd
> taken into account.
>
> So let's permit reserved memory regions to exist in the region starting a=
t the base
> of RAM, and ending at TEXT_OFFSET - 5 * PAGE_SIZE, which is the window be=
low
> the kernel that is not touched by the early boot code.
>
> Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
> Cc: Chester Lin <clin@suse.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Guillaume Gardet <Guillaume.Gardet@arm.com>

> ---
>  drivers/firmware/efi/libstub/Makefile     |  1 +
>  drivers/firmware/efi/libstub/arm32-stub.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile
> b/drivers/firmware/efi/libstub/Makefile
> index 0460c7581220..ee0661ddb25b 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)   +=3D arm-stub.o fdt.o
> string.o random.o \
>
>  lib-$(CONFIG_ARM)            +=3D arm32-stub.o
>  lib-$(CONFIG_ARM64)          +=3D arm64-stub.o
> +CFLAGS_arm32-stub.o          :=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o          :=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
>
>  #
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
> b/drivers/firmware/efi/libstub/arm32-stub.c
> index e8f7aefb6813..47aafeff3e01 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -195,6 +195,7 @@ efi_status_t handle_kernel_image(efi_system_table_t
> *sys_table,
>                                unsigned long dram_base,
>                                efi_loaded_image_t *image)
>  {
> +     unsigned long kernel_base;
>       efi_status_t status;
>
>       /*
> @@ -204,9 +205,18 @@ efi_status_t handle_kernel_image(efi_system_table_t
> *sys_table,
>        * loaded. These assumptions are made by the decompressor,
>        * before any memory map is available.
>        */
> -     dram_base =3D round_up(dram_base, SZ_128M);
> +     kernel_base =3D round_up(dram_base, SZ_128M);
>
> -     status =3D reserve_kernel_base(sys_table, dram_base, reserve_addr,
> +     /*
> +      * Note that some platforms (notably, the Raspberry Pi 2) put
> +      * spin-tables and other pieces of firmware at the base of RAM,
> +      * abusing the fact that the window of TEXT_OFFSET bytes at the
> +      * base of the kernel image is only partially used at the moment.
> +      * (Up to 5 pages are used for the swapper page table)
> +      */
> +     kernel_base +=3D TEXT_OFFSET - 5 * PAGE_SIZE;
> +
> +     status =3D reserve_kernel_base(sys_table, kernel_base, reserve_addr=
,
>                                    reserve_size);
>       if (status !=3D EFI_SUCCESS) {
>               pr_efi_err(sys_table, "Unable to allocate memory for
> uncompressed kernel.\n"); @@ -220,7 +230,7 @@ efi_status_t
> handle_kernel_image(efi_system_table_t *sys_table,
>       *image_size =3D image->image_size;
>       status =3D efi_relocate_kernel(sys_table, image_addr, *image_size,
>                                    *image_size,
> -                                  dram_base + MAX_UNCOMP_KERNEL_SIZE, 0)=
;
> +                                  kernel_base + MAX_UNCOMP_KERNEL_SIZE,
> 0);
>       if (status !=3D EFI_SUCCESS) {
>               pr_efi_err(sys_table, "Failed to relocate kernel.\n");
>               efi_free(sys_table, *reserve_size, *reserve_addr);
> --
> 2.20.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
