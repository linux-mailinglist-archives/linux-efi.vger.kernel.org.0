Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA816F025
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgBYUei (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 15:34:38 -0500
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:2369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731800AbgBYUeh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 15:34:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKYTFt36oNphxgv7PGqxXH7xwRZYcEDAvDDVAzV6Rq6rTtDsc5oiI7ZD0ITntapcY0jKqcMdj0+/P/M3j0LM27kQb3xZ74/ft0C+OFLw8+6PmQInzfQBERMjjdeT6tXxRSQmJNFYrkebQU7vBc15y+jDcvpkuCYMK6+OEA//yZBuNYEoojeH8HzOlN5whHJIGbpDPySgaNQPlBa/AUyF3j4D0VnUoHzIziEqOA4j2Ci50w6lSLGckZyN7zE+TgHB21lfBClf3jQt+POyW4A7H3zjl3+1VdFXsU6kD42b7oVMkEnlUknFZJlule9KQSKlqZAvf/To+fKsSZWrh8jO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLHq/uAacxCZkAwiRD8F34wV8vzLnHcS9NfIjZVjOjs=;
 b=BuMTkKJW5je4DTwNjwegv7RG8aC61pX0CTlufB+xCil5L7F2IMuR+Q4vfTsq6Rkno9FjOivgRo+IVkHvnxIY1+gS+xVaZkhGsLYlLTuOzVmmWaeJ5iv+O+tVlS2fSXqWJB18rkQE3NhL+gAMHYqBaPwiHaTlIjS8q2WFEbJDxTFFPlPsldBBCTddfXMlwSpR/EFp81Q/VIU6dG3s5k7oq4KeC0eTdbv3bRNh/jtMdlN95BULZjEH9yHMkbx7ip7vY0gmp6qZv4N0PX1cy2RTsfzrxM4yVV0+Icb9zC3S7GHYCp/uhQ795bxK6Zrb3eP57HCTnzIy3bQsiT+sRDmoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLHq/uAacxCZkAwiRD8F34wV8vzLnHcS9NfIjZVjOjs=;
 b=WLqp3RguM7Po0xKfI6fQcbqLoau5R+cXWdIeSNRuLvrShj5J8FGFtLNvoWEJb4DrrUTh8MH+pTDJHpn7vvJfHSmLnBE7z8ek+FYkXECSC8Fa/9vSL/m8WSjm9s71g8d+CUFt2uZv6JZ3kCdO90jon6QHxXvmDlJ7FHhzpMhyMOI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 20:34:35 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 20:34:35 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/2] x86/efi: Add RNG seed EFI table to unencrypted mapping check
Date:   Tue, 25 Feb 2020 14:34:02 -0600
Message-Id: <b64385fc13e5d7ad4b459216524f138e7879234f.1582662842.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1582662842.git.thomas.lendacky@amd.com>
References: <cover.1582662842.git.thomas.lendacky@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0012.namprd07.prod.outlook.com
 (2603:10b6:803:28::22) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN4PR0701CA0012.namprd07.prod.outlook.com (2603:10b6:803:28::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 20:34:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 390e3279-7a68-4085-9a0c-08d7ba321e7d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:|DM6PR12MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443463F672946DFE79332BD3ECED0@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(956004)(6486002)(7416002)(52116002)(7696005)(66556008)(316002)(5660300002)(2616005)(6666004)(66946007)(36756003)(86362001)(186003)(81156014)(2906002)(81166006)(4326008)(54906003)(16526019)(66476007)(8936002)(26005)(8676002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4434;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO5P/9c4AsQi6+ee3YmBrMgqX8uiYd1HFKp3hZjOM829Ra8zzuclrfZjHJoD57D48vhNLK/lh6VQLVKiOfi3XyIDfeBcrRjkbmsC64ji7KWvf4Gb9qJYFXCU8OrD3AuPQM4P6nw3EyI+Rjm3W+8qtpaTW/Imk8GowIl5qdknaDccrICHFhzX0vFiuiGoWXaIRNkVuRPDmf44KDRnHTevRxMUwkMa7S82a65dguBTDQXLaoh57s7bNjMyYO4jo9KZnQcM3Rjj7S+kFR+u8V61mmUW5BrW52arz+MUsBr1hv6BtiKrNWjAV5wQ8xQvIG/l6Y8oD5C9OiyOIgifHSl6VLtf63Ufmzu+ZNHkaEU9/pwUqH9BSbg2oEWjMBB5IFU4hM/RkTAKNw7V2ePVFgQ/70RrRDJKcBBxmzNc2R6d318vbJ+VFy30f4MKLTEvJ6f4
X-MS-Exchange-AntiSpam-MessageData: wC+GuqMl1FAKqbEspzcKzACiGhhnsfZTW5VmuB488XDIru9hrhJNkfLSSn+6a7vOvxm+8qDwrgall8rndpjdKw6Aqq4HovZ/ZuqrosrchzZOqlaZhCCxCdkPwd9rLKo0SAg/qsm/IgjtgtaA1+kLhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e3279-7a68-4085-9a0c-08d7ba321e7d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 20:34:34.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX1dM49RhfnOFHseB+6TyjfPNSqiAuKnRwJv3vhx08CRddWU5hKiAU3we3gvnhRk0DJ8Jp/nK58y34x7z50k8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When booting with SME active, EFI tables must be mapped unencrypted since
they were built by UEFI in unencrypted memory. Update the list of tables
to be checked during early_memremap() processing to account for the EFI
RNG seed table.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/platform/efi/efi.c |  1 +
 drivers/firmware/efi/efi.c  | 18 ++++++++++--------
 include/linux/efi.h         |  2 ++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 0a8117865430..aca9bdd87bca 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -90,6 +90,7 @@ static const unsigned long * const efi_tables[] = {
 #endif
 	&efi.tpm_log,
 	&efi.tpm_final_log,
+	&efi_rng_seed,
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69a585106d30..1e79f77d4e6c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -45,7 +45,7 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static unsigned long __ro_after_init rng_seed = EFI_INVALID_TABLE_ADDR;
+unsigned long __ro_after_init efi_rng_seed = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 
@@ -451,7 +451,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
 	{EFI_SYSTEM_RESOURCE_TABLE_GUID, "ESRT", &efi.esrt},
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi_mem_attr_table},
-	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &rng_seed},
+	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi_rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &mem_reserve},
@@ -519,11 +519,11 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 	pr_cont("\n");
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
-	if (rng_seed != EFI_INVALID_TABLE_ADDR) {
+	if (efi_rng_seed != EFI_INVALID_TABLE_ADDR) {
 		struct linux_efi_random_seed *seed;
 		u32 size = 0;
 
-		seed = early_memremap(rng_seed, sizeof(*seed));
+		seed = early_memremap(efi_rng_seed, sizeof(*seed));
 		if (seed != NULL) {
 			size = seed->size;
 			early_memunmap(seed, sizeof(*seed));
@@ -531,7 +531,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			pr_err("Could not map UEFI random seed!\n");
 		}
 		if (size > 0) {
-			seed = early_memremap(rng_seed, sizeof(*seed) + size);
+			seed = early_memremap(efi_rng_seed,
+					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
 				add_bootloader_randomness(seed->bits, seed->size);
@@ -923,7 +924,7 @@ static int update_efi_random_seed(struct notifier_block *nb,
 	if (!kexec_in_progress)
 		return NOTIFY_DONE;
 
-	seed = memremap(rng_seed, sizeof(*seed), MEMREMAP_WB);
+	seed = memremap(efi_rng_seed, sizeof(*seed), MEMREMAP_WB);
 	if (seed != NULL) {
 		size = min(seed->size, EFI_RANDOM_SEED_SIZE);
 		memunmap(seed);
@@ -931,7 +932,8 @@ static int update_efi_random_seed(struct notifier_block *nb,
 		pr_err("Could not map UEFI random seed!\n");
 	}
 	if (size > 0) {
-		seed = memremap(rng_seed, sizeof(*seed) + size, MEMREMAP_WB);
+		seed = memremap(efi_rng_seed, sizeof(*seed) + size,
+				MEMREMAP_WB);
 		if (seed != NULL) {
 			seed->size = size;
 			get_random_bytes(seed->bits, seed->size);
@@ -949,7 +951,7 @@ static struct notifier_block efi_random_seed_nb = {
 
 static int __init register_update_efi_random_seed(void)
 {
-	if (rng_seed == EFI_INVALID_TABLE_ADDR)
+	if (efi_rng_seed == EFI_INVALID_TABLE_ADDR)
 		return 0;
 	return register_reboot_notifier(&efi_random_seed_nb);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2ab33d5d6ca5..e8a08a499131 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -526,6 +526,8 @@ typedef struct {
 	efi_time_t time_of_revocation;
 } efi_cert_x509_sha256_t;
 
+extern unsigned long __ro_after_init efi_rng_seed;		/* RNG Seed table */
+
 /*
  * All runtime access to EFI goes through this structure:
  */
-- 
2.17.1

