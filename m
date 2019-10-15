Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0096FD6D33
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJOC1Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Mon, 14 Oct 2019 22:27:16 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:46556 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfJOC1Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 22:27:16 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Tue, 15 Oct 2019 02:26:35 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 15 Oct 2019 02:26:35 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 15 Oct 2019 02:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heBL3PE4vc3iGGgWzHRa1EnEYl9A7b+bx6zHifFjeg9f6MORa8j0qcxUKzD82VhO0763NBhJJISj1SXAqKx/Nw1UoKemQeSBjgkkP/6vBACGD6ktJ6x6nFTw7mihNNCFwRx+uCzAt+PTcsuV4/ClHAiLtE+BsHl+I6Xz2h2B13IL1zi8egPZvEjK57Z9lmSJS7hihaoAGQ3DEZ3dKVGOQsDcacuEiolyw80YFZ+5yavfkut+eYgRDCqZvv815evjRsw7moOaW7IMwE3DEm0cVaZ+KvwlJbBkEvw0Qvxoxb7D8gSRZPpMjuC6M4uzJbHQoRbLrco4NGRxCZy2dH1x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/VaBKPeW2biVfhx6zy1mfbG9NIbWNc7zdOPiUUO36k=;
 b=Rv2vMuAv7Q/4gfZw3hk6TfJl6n70Nl9b+Jj7/0zhZ/QOpzECn0Y/DTpmOCG6tWgXuhpmZ4rj2mlXizFPIY+lC5T7DS7Sd9zdGvSJ+DTLLNPwB5KCZXtJ3DnhQlltUaeY+yD/fV0ffjPthwUNyYQi9X+MlRzQZMeeaoMpyNYEKh1IKopWOrp7jqCP4RzyjkAZ74vd4qAeID2nKWHyRT6TsOBrNS94Q5KXgO3NwOLqHdxqG+jK+C2VbwWDL8rVU213xg4iEoYai2WruuJdNt8YOWfy+/W1iBY8xN3YiBeqkAcVxAfEPenWD445wJc/fSrmQNfAGckEWRWZTkbeaI0c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3156.namprd18.prod.outlook.com (10.255.138.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 02:26:28 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::4dd:8429:a080:e36f]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::4dd:8429:a080:e36f%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 02:26:28 +0000
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Chester Lin <clin@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi: libstub/arm: account for firmware reserved memory at
 the base of RAM
Thread-Topic: [PATCH] efi: libstub/arm: account for firmware reserved memory
 at the base of RAM
Thread-Index: AQHVgq0o322HKzqnAEenGFvO5wTA56da+nuA
Date:   Tue, 15 Oct 2019 02:26:28 +0000
Message-ID: <20191015022615.GA7281@linux-8mug>
References: <20191014163309.2860-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20191014163309.2860-1-ard.biesheuvel@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14cd6103-94cb-4785-4441-08d751171558
x-ms-traffictypediagnostic: BY5PR18MB3156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB31565BBF397642B0E407E44FAD930@BY5PR18MB3156.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(14454004)(71200400001)(6436002)(71190400001)(8936002)(256004)(14444005)(3846002)(186003)(102836004)(86362001)(55236004)(6116002)(81166006)(8676002)(66946007)(81156014)(478600001)(6246003)(66066001)(6486002)(9686003)(33716001)(66476007)(66446008)(64756008)(66556008)(6512007)(229853002)(316002)(52116002)(76176011)(4326008)(26005)(386003)(486006)(6916009)(99286004)(305945005)(7736002)(476003)(2906002)(11346002)(33656002)(6506007)(446003)(54906003)(1076003)(5660300002)(25786009)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3156;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiRKbonqPzAkoaCmS6cwMvIs5UbPMdDexXt8E4MXzNeRXXQssOs5UfXL7bb5qEWjc/t9YdT4BBN2kVCUao2MoD5WSSlUjBYMzDOqPP8bF8zKsEsJOOhyCMSy0Sqe1Xu+aCWnG1KDf1w33RXtuajmuXinGJI7cFGOPKClB/JjqkdhDgDYOlhMMLS3kKP2+PGyKQYrGjEbnywO2nv/tWeS6Mk5SGv3sP8neUonmkt+fb5Ctf7m76HitqoLDJOGWYdm2pDz0ym/DbX0F7u0fL6jykrivtd9Fw7m2FE3d7QjlAV4NjNXePR5OhVZurFGJlf/ZVTLg6Nn2fl/6lsBRjXpXF1dNxppDYZtCTfFuGIiWQCsNlNgmt3EcD5/+euclIVIWWw1Td4HM8sYzACayHiLUDkQLHUtC5aSFKrScq2tBN8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7E61727FF636549AF1988621960A25D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cd6103-94cb-4785-4441-08d751171558
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 02:26:28.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiyrlbdcMKOai9kKfYUll0nc7z7+KsERqaHX+cbJk3vZ8o+0+HPyU+gtk1HLahAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3156
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 06:33:09PM +0200, Ard Biesheuvel wrote:
> The EFI stubloader for ARM starts out by allocating a 32 MB window
> at the base of RAM, in order to ensure that the decompressor (which
> blindly copies the uncompressed kernel into that window) does not
> overwrite other allocations that are made while running in the context
> of the EFI firmware.
> 
> In some cases, (e.g., U-Boot running on the Raspberry Pi 2), this is
> causing boot failures because this initial allocation conflicts with
> a page of reserved memory at the base of RAM that contains the SMP spin
> tables and other pieces of firmware data and which was put there by
> the bootloader under the assumption that the TEXT_OFFSET window right
> below the kernel is only used partially during early boot, and will be
> left alone once the memory reservations are processed and taken into
> account.
> 
> So let's permit reserved memory regions to exist in the region starting
> at the base of RAM, and ending at TEXT_OFFSET - 5 * PAGE_SIZE, which is
> the window below the kernel that is not touched by the early boot code.
> 
> Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
> Cc: Chester Lin <clin@suse.com> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/Makefile     |  1 +
>  drivers/firmware/efi/libstub/arm32-stub.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 0460c7581220..ee0661ddb25b 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
>  
>  lib-$(CONFIG_ARM)		+= arm32-stub.o
>  lib-$(CONFIG_ARM64)		+= arm64-stub.o
> +CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  
>  #
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> index e8f7aefb6813..47aafeff3e01 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -195,6 +195,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>  				 unsigned long dram_base,
>  				 efi_loaded_image_t *image)
>  {
> +	unsigned long kernel_base;
>  	efi_status_t status;
>  
>  	/*
> @@ -204,9 +205,18 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>  	 * loaded. These assumptions are made by the decompressor,
>  	 * before any memory map is available.
>  	 */
> -	dram_base = round_up(dram_base, SZ_128M);
> +	kernel_base = round_up(dram_base, SZ_128M);
>  
> -	status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
> +	/*
> +	 * Note that some platforms (notably, the Raspberry Pi 2) put
> +	 * spin-tables and other pieces of firmware at the base of RAM,
> +	 * abusing the fact that the window of TEXT_OFFSET bytes at the
> +	 * base of the kernel image is only partially used at the moment.
> +	 * (Up to 5 pages are used for the swapper page table)
> +	 */
> +	kernel_base += TEXT_OFFSET - 5 * PAGE_SIZE;
> +
> +	status = reserve_kernel_base(sys_table, kernel_base, reserve_addr,
>  				     reserve_size);
>  	if (status != EFI_SUCCESS) {
>  		pr_efi_err(sys_table, "Unable to allocate memory for uncompressed kernel.\n");
> @@ -220,7 +230,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>  	*image_size = image->image_size;
>  	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
>  				     *image_size,
> -				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
> +				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0);
>  	if (status != EFI_SUCCESS) {
>  		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
>  		efi_free(sys_table, *reserve_size, *reserve_addr);

Acked-by: Chester Lin <clin@suse.com>
