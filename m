Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5F6545F6
	for <lists+linux-efi@lfdr.de>; Thu, 22 Dec 2022 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiLVSaq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 13:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVSao (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 13:30:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC112AF2;
        Thu, 22 Dec 2022 10:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYBC/8xjN5yFLuDRDQziYv7W6KDRZWn+mtIXtPlLNzBj9Ty1ibGadR17vYKCqDoio4drzoqHsjKeK7JBZnry/qG7YbDEw+JExveP4f/2WoH8Zpmhmxabn5H0NSae0XWlMFbx4pvaCE6vLBD/7rihbJIImF7md4J6P0dzGMeDB4ObombjAvJVlrmn1oMht/Y+50Nmjo0Z2ELGc6bQBZ+3hcpAxAzCZe5CWaFnCId+LXEZfuvz/09tAInmWaYWCT0nY7buECdNOE4ULhKVQPwae+bLtvftHZXiNJH+y9fsfDOkoTswJKPGnFiyJRMWYhi7PcHjzcaVTDZpFRIMzBxUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baZISl2xHD5RFTWWB3obPEV/QIGPuK7ekfeJv5IvwYs=;
 b=DIWh53xRFt/KffxIdxzyEC+/GDlHxK0E+FB0FZPPI9LWTqS0uV2uVnbsUbcctvt94/4fdHvD8vKRh9aWkd4votLMoKU1b0RNOyMnyAJ+mGcLQUmU8aDGYomrqoec7j4sbWzH09kMzm8Y+ob1nx2lmFJOIT3FhtEPoryzinxHLwhZ8BpOo/3exIkZoFA/SQgdAkq9hn/POwgyMPxopdLoERfGOEwZ7B+gbvwzyyTSbe+dyclZdNn6PHlEyIpcq2QQazjWY1AE1wivOTuxen+4p2obhIKLwdNGCOa7yf34A2+ivoV/DO5Q+1+eTmV3/KL01O36b5DDb/OYAdi3DBEudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baZISl2xHD5RFTWWB3obPEV/QIGPuK7ekfeJv5IvwYs=;
 b=hRmgXD3dP5vJWLQqECm7Kei9aSDQx7NsW0f/WwNOjJ8QApkuRbVSaXtWmN4YUyer50VW0tX8RbGuoW1RFw7VYNvJ9Loo5P7dn6Wb+KLcbKLpT+9buspQahsLGwVy86DqxazCr1vcUB+GMNnQ8DTZuslUwP7Z7FFgAnrmXdAQW5g=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:30:36 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::3f) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 18:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Thu, 22 Dec 2022 18:30:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 12:30:34 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <linux-efi@vger.kernel.org>
CC:     Carlos Soriano Sanchez <csoriano@redhat.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        "David Airlie" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Recover from failure to probe GPU
Date:   Thu, 22 Dec 2022 12:30:09 -0600
Message-ID: <20221222183012.1046-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: be75b191-527e-4fa5-7334-08dae44a9ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8UKc94ut6N8m1OA6FmQxFpBTmX0GIU/eEMNyWhuUYth+aWN/u5cxRarz6Ktt7Bcb98O5RfjrOmowVoe5SBhHD2b00f+lnFcCHPoipYrKn9IzAGW0DMg2Fd6lUjs3FJBCDIh2Tsm5RyIj8lQxAWXe25MLEjPygtOPbIxmblLXWKm0uAHQ3Z/FFjyaYzaDQr0OQRhIsTF1QA6i04Hg1n05UuuaGXO6bZ4xYCctrUpZrchSFOYbPV7Plpj6BIy8uuy5fPZmebkGxRzmSUHYxq1nB9Gz2hyODxSH57LPTKgH2hU8CMVUFiJJVKgN26qAu643lWfg5FYQOfuTpaVgD7K7iXrAPHfNNsre7BHc3Fk18b8DJJFxAlsstc0A/U9zJWprlZMiOMejYoriliOy/5bjJZstgoDX+7wM51nwQf2LBq52RAeWshljiHY06hE4xoWu2yW69HVcygTuxGuJ5OO09fCKDgYSVAWYgMQXsOvyfuqaXesrbTreQngUFqw/p2LI9jJfKdF/NW/THyfckVN2PRQPzEfOPi5YjGa2Zlz7SdguiC1Xd3FBcozbfUR8aqn7ntygWabjj7+n1T2+NVqm8/4V8KAkOXVQ/OUwFQ9vNHoG90DmR/67BfHFQHheXsvhk2ox802ejSg75mZ8sKXDGKBk3rdR6XZZK79kczopP21tL5wUfVL5kjq5sxw/MLuAo6UOoTqF9jpCQFdMehvk6RN44k0hbu7ITsphMAwjVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(54906003)(2906002)(8936002)(36756003)(426003)(110136005)(47076005)(316002)(83380400001)(478600001)(40460700003)(336012)(16526019)(40480700001)(6666004)(1076003)(2616005)(86362001)(26005)(186003)(7696005)(36860700001)(82310400005)(41300700001)(82740400003)(5660300002)(70586007)(81166007)(70206006)(4326008)(356005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:30:36.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be75b191-527e-4fa5-7334-08dae44a9ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

One of the first thing that KMS drivers do during initialization is
destroy the system firmware framebuffer by means of
`drm_aperture_remove_conflicting_pci_framebuffers`

This means that if for any reason the GPU failed to probe the user
will be stuck with at best a screen frozen at the last thing that
was shown before the KMS driver continued it's probe.

The problem is most pronounced when new GPU support is introduced
because users will need to have a recent linux-firmware snapshot
on their system when they boot a kernel with matching support.

However the problem is further exaggerated in the case of amdgpu because
it has migrated to "IP discovery" where amdgpu will attempt to load
on "ALL" AMD GPUs even if the driver is missing support for IP blocks
contained in that GPU.

IP discovery requires some probing and isn't run until after the
framebuffer has been destroyed.

This means a situation can occur where a user purchases a new GPU not
yet supported by a distribution and when booting the installer it will
"freeze" even if the distribution doesn't have the matching kernel support
for those IP blocks.

The perfect example of this is Ubuntu 21.10 and the new dGPUs just
launched by AMD.  The installation media ships with kernel 5.19 (which
has IP discovery) but the amdgpu support for those IP blocks landed in
kernel 6.0. The matching linux-firmware was released after 21.10's launch.
The screen will freeze without nomodeset. Even if a user manages to install
and then upgrades to kernel 6.0 after install they'll still have the
problem of missing firmware, and the same experience.

This is quite jarring for users, particularly if they don't know
that they have to use "nomodeset" to install.

To help the situation, allow drivers to re-run the init process for the
firmware framebuffer during a failed probe. As this problem is most
pronounced with amdgpu, this is the only driver changed.

But if this makes sense more generally for other KMS drivers, the call
can be added to the cleanup routine for those too.

Here is a sample of what happens with missing GPU firmware and this
series:

[    5.950056] amdgpu 0000:63:00.0: vgaarb: deactivate vga console
[    5.950114] amdgpu 0000:63:00.0: enabling device (0006 -> 0007)
[    5.950883] [drm] initializing kernel modesetting (YELLOW_CARP 0x1002:0x1681 0x17AA:0x22F1 0xD2).
[    5.952954] [drm] register mmio base: 0xB0A00000
[    5.952958] [drm] register mmio size: 524288
[    5.954633] [drm] add ip block number 0 <nv_common>
[    5.954636] [drm] add ip block number 1 <gmc_v10_0>
[    5.954637] [drm] add ip block number 2 <navi10_ih>
[    5.954638] [drm] add ip block number 3 <psp>
[    5.954639] [drm] add ip block number 4 <smu>
[    5.954641] [drm] add ip block number 5 <dm>
[    5.954642] [drm] add ip block number 6 <gfx_v10_0>
[    5.954643] [drm] add ip block number 7 <sdma_v5_2>
[    5.954644] [drm] add ip block number 8 <vcn_v3_0>
[    5.954645] [drm] add ip block number 9 <jpeg_v3_0>
[    5.954663] amdgpu 0000:63:00.0: amdgpu: Fetched VBIOS from VFCT
[    5.954666] amdgpu: ATOM BIOS: 113-REMBRANDT-X37
[    5.954677] [drm] VCN(0) decode is enabled in VM mode
[    5.954678] [drm] VCN(0) encode is enabled in VM mode
[    5.954680] [drm] JPEG decode is enabled in VM mode
[    5.954681] amdgpu 0000:63:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
[    5.954683] amdgpu 0000:63:00.0: amdgpu: PCIE atomic ops is not supported
[    5.954724] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    5.954732] amdgpu 0000:63:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    5.954735] amdgpu 0000:63:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    5.954738] amdgpu 0000:63:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    5.954747] [drm] Detected VRAM RAM=512M, BAR=512M
[    5.954750] [drm] RAM width 256bits LPDDR5
[    5.954834] [drm] amdgpu: 512M of VRAM memory ready
[    5.954838] [drm] amdgpu: 15680M of GTT memory ready.
[    5.954873] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.955333] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
[    5.955502] amdgpu 0000:63:00.0: Direct firmware load for amdgpu/yellow_carp_toc.bin failed with error -2
[    5.955505] amdgpu 0000:63:00.0: amdgpu: fail to request/validate toc microcode
[    5.955510] [drm:psp_sw_init [amdgpu]] *ERROR* Failed to load psp firmware!
[    5.955725] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init of IP block <psp> failed -2
[    5.955952] amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_init failed
[    5.955954] amdgpu 0000:63:00.0: amdgpu: Fatal error during GPU init
[    5.955957] amdgpu 0000:63:00.0: amdgpu: amdgpu: finishing device.
[    5.971162] efifb: probing for efifb
[    5.971281] efifb: showing boot graphics
[    5.974803] efifb: framebuffer at 0x910000000, using 20252k, total 20250k
[    5.974805] efifb: mode is 2880x1800x32, linelength=11520, pages=1
[    5.974807] efifb: scrolling: redraw
[    5.974807] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    5.974974] Console: switching to colour frame buffer device 180x56
[    5.978181] fb0: EFI VGA frame buffer device
[    5.978199] amdgpu: probe of 0000:63:00.0 failed with error -2
[    5.978285] [drm] amdgpu: ttm finalized

Now if the user loads the firmware into the system they can re-load the
driver or re-attach using sysfs and it gracefully recovers.

[  665.080480] [drm] Initialized amdgpu 3.49.0 20150101 for 0000:63:00.0 on minor 0
[  665.090075] fbcon: amdgpudrmfb (fb0) is primary device
[  665.090248] [drm] DSC precompute is not needed.

Mario Limonciello (2):
  firmware: sysfb: Allow re-creating system framebuffer after init
  drm/amd: Re-create firmware framebuffer on failure to probe

 drivers/firmware/efi/sysfb_efi.c        |  6 +++---
 drivers/firmware/sysfb.c                | 15 ++++++++++++++-
 drivers/firmware/sysfb_simplefb.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 include/linux/sysfb.h                   |  5 +++++
 5 files changed, 26 insertions(+), 6 deletions(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.34.1

