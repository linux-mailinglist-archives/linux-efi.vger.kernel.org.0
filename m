Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA387EC2A
	for <lists+linux-efi@lfdr.de>; Fri,  2 Aug 2019 07:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfHBFk3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Fri, 2 Aug 2019 01:40:29 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:40443 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387606AbfHBFk3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Aug 2019 01:40:29 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Fri,  2 Aug 2019 05:40:26 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 2 Aug 2019 05:38:57 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 2 Aug 2019 05:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPwSaWkb89TnldbJzamri34EfJ2flnipu86YVpLH4Kc6pvsb2xYHPlkRhYbGNIfuYkhaIlWG6XHvAVLia7gO4pD7mV2QCyEbYBBAEGI9Q1ocVkuUhZfhQIk9LdTMXqKRC89SV8Mmouieg+9TbQGQD0Gpbr90bW1ZCztYQNrf2i4GIis4uhGqWbE+uXBk0rFPjWRpJD0OMIp0i5ikLGzCFaRuHGUfOnwKq5iGrIWmIfC7FmTQn6opcIPkv+vSbXAr6a7WMFNnEXSHDIDDQkzOT55XxSFNOOO08wPTwGqhM1NSbGsirGxhZIkOHnf+1vkLCcwUawN4RPN+9WLljO7iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si4+r8o+rP+N8BbH3mwBlBHg1ApzRq7/AOUl2iP1IBU=;
 b=Js1UWA+LwzosYwtsLYTBWpDVAhtum2ejWsPGmNGpaB4GSZ17KZGJ1xAxwGTNnNv4gbZh33o6K6cD/HjQiw57IHxMFv8Jz/VRENFb9cVmXZhCJhbvozs7CYTfMO1saoNipqNxgcEGnSVFslH1tEHp7tZHDTpo7KeuK2jVfPuntr/qlfNWcog39adgsMLVdjYNnGiRzm4t5cawW1b6oY0XMFsMhAxKuua5i/1sZHT8f7U8lc98I94C8XEN0qjPqgtLAv59jJ8JcdK9FKp8ZuSjV3WsDLAu6XyDcsTsw/h4RpbqJnW+MO0wMcUl2jbhGeGWqOPW35Bg5ClJG6f4l3lXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3348.namprd18.prod.outlook.com (10.255.136.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Fri, 2 Aug 2019 05:38:55 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 05:38:54 +0000
From:   Chester Lin <clin@suse.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Chester Lin <clin@suse.com>, Joey Lee <JLee@suse.com>,
        Gary Lin <GLin@suse.com>
Subject: [PATCH] efi/arm: fix allocation failure when reserving the kernel
 base
Thread-Topic: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
Thread-Index: AQHVSPSS9nx4lee000qskpi0lgLxmA==
Date:   Fri, 2 Aug 2019 05:38:54 +0000
Message-ID: <20190802053744.5519-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::26) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c4329d6-772e-40f8-00ab-08d7170bb4f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3348;
x-ms-traffictypediagnostic: BY5PR18MB3348:
x-microsoft-antispam-prvs: <BY5PR18MB3348CA15D936C66D68C653C3ADD90@BY5PR18MB3348.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(1076003)(110136005)(316002)(54906003)(71200400001)(71190400001)(14444005)(256004)(7416002)(2616005)(476003)(486006)(2501003)(99286004)(107886003)(52116002)(6116002)(3846002)(2201001)(53936002)(5660300002)(6436002)(6512007)(66946007)(66476007)(66446008)(2906002)(26005)(64756008)(386003)(4326008)(6506007)(25786009)(102836004)(68736007)(66556008)(6486002)(66066001)(186003)(8936002)(14454004)(8676002)(81166006)(36756003)(81156014)(478600001)(86362001)(305945005)(7736002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3348;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0fZkyP2e/qQuskWnLqlulfMsrGtMbYBdpe9c5aA1IOKBmwuZSXQManj7afFaIkT8D4NyAfG4zmKCtuDId/tSgqJBXbABrVC+sCQ8tAYhA0rK4D2vTW7VISG2G3nPqet8HSXB4T2Zc/Gb6LM5QOyHsVpF4bZABoAwmDyYbbzmxGtsauod0R6DdirIOu+ie6Kw6NbuJgNXDrRCQI0bxT1iLQIKbxal75LK7c0OwKiIAoPq95P5/Im6ij2wkvgYAgwB6SZvCMv4tGajASHpCNrUq+obnuIQO4Jj2m5BisfCurnQ/6D/YuOt1DmEdzBcq99A8sGaNPex3kZ2RE6fEvO0Y/ZY0FlNcm2xl4GNZ/6TB03Kd6nHrg9sDM+zwkUSJwzCzQfenuL4BLdUYsaexmsCL12YOj9h+uM34NW3Xmzup1w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4329d6-772e-40f8-00ab-08d7170bb4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 05:38:54.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3348
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In some cases the arm32 efistub could fail to allocate memory for
uncompressed kernel. For example, we got the following error message when
verifying EFI stub on Raspberry Pi-2 [kernel-5.2.1 + grub-2.04] :

  EFI stub: Booting Linux Kernel...
  EFI stub: ERROR: Unable to allocate memory for uncompressed kernel.
  EFI stub: ERROR: Failed to relocate kernel

After checking the EFI memory map we found that the first page [0 - 0xfff]
had been reserved by Raspberry Pi-2's firmware, and the efistub tried to
set the dram base at 0, which was actually in a reserved region.

  grub> lsefimmap
  Type      Physical start  - end             #Pages        Size Attributes
  reserved  0000000000000000-0000000000000fff 00000001      4KiB WB
  conv-mem  0000000000001000-0000000007ef5fff 00007ef5 130004KiB WB
  RT-data   0000000007ef6000-0000000007f09fff 00000014     80KiB RT WB
  conv-mem  0000000007f0a000-000000002d871fff 00025968 615840KiB WB
  .....

To avoid a reserved address, we have to ignore the memory regions which are
marked as EFI_RESERVED_TYPE, and only conventional memory regions can be
chosen. If the region before the kernel base is unaligned, it will be
marked as EFI_RESERVED_TYPE and let kernel ignore it so that memblock_limit
will not be sticked with a very low address such as 0x1000.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm/mm/mmu.c                         |  3 ++
 drivers/firmware/efi/libstub/arm32-stub.c | 43 ++++++++++++++++++-----
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f3ce34113f89..909b11ba48d8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
 
+		if (memblock_is_nomap(reg))
+			continue;
+
 		if (reg->base < vmalloc_limit) {
 			if (block_end > lowmem_limit)
 				/*
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..10d33d36df00 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -128,7 +128,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 
 	for (l = 0; l < map_size; l += desc_size) {
 		efi_memory_desc_t *desc;
-		u64 start, end;
+		u64 start, end, spare, kernel_base;
 
 		desc = (void *)memory_map + l;
 		start = desc->phys_addr;
@@ -144,27 +144,52 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 		case EFI_BOOT_SERVICES_DATA:
 			/* Ignore types that are released to the OS anyway */
 			continue;
-
+		case EFI_RESERVED_TYPE:
+			/* Ignore reserved regions */
+			continue;
 		case EFI_CONVENTIONAL_MEMORY:
 			/*
 			 * Reserve the intersection between this entry and the
 			 * region.
 			 */
 			start = max(start, (u64)dram_base);
-			end = min(end, (u64)dram_base + MAX_UNCOMP_KERNEL_SIZE);
+			kernel_base = round_up(start, PMD_SIZE);
+			spare = kernel_base - start;
+			end = min(end, kernel_base + MAX_UNCOMP_KERNEL_SIZE);
+
+			status = efi_call_early(allocate_pages,
+					EFI_ALLOCATE_ADDRESS,
+					EFI_LOADER_DATA,
+					MAX_UNCOMP_KERNEL_SIZE / EFI_PAGE_SIZE,
+					&kernel_base);
+			if (status != EFI_SUCCESS) {
+				pr_efi_err(sys_table_arg,
+					"reserve_kernel_base: alloc failed.\n");
+				goto out;
+			}
+			*reserve_addr = kernel_base;
 
+			if (!spare)
+				break;
+			/*
+			 * If there's a gap between start and kernel_base,
+			 * it needs be reserved so that the memblock_limit
+			 * will not fall on a very low address when running
+			 * adjust_lowmem_bounds(), wchich could eventually
+			 * cause CMA reservation issue.
+			 */
 			status = efi_call_early(allocate_pages,
 						EFI_ALLOCATE_ADDRESS,
-						EFI_LOADER_DATA,
-						(end - start) / EFI_PAGE_SIZE,
+						EFI_RESERVED_TYPE,
+						spare / EFI_PAGE_SIZE,
 						&start);
 			if (status != EFI_SUCCESS) {
 				pr_efi_err(sys_table_arg,
-					"reserve_kernel_base(): alloc failed.\n");
+					"reserve spare-region failed\n");
 				goto out;
 			}
-			break;
 
+			break;
 		case EFI_LOADER_CODE:
 		case EFI_LOADER_DATA:
 			/*
@@ -220,7 +245,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     *reserve_addr + MAX_UNCOMP_KERNEL_SIZE, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
@@ -233,7 +258,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 * in memory. The kernel determines the base of DRAM from the
 	 * address at which the zImage is loaded.
 	 */
-	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
+	if (*image_addr + *image_size > *reserve_addr + ZIMAGE_OFFSET_LIMIT) {
 		pr_efi_err(sys_table, "Failed to relocate kernel, no low memory available.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
 		*reserve_size = 0;
-- 
2.22.0

