Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDE64AD22
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 02:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiLMBgd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Dec 2022 20:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiLMBgc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Dec 2022 20:36:32 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D601D673;
        Mon, 12 Dec 2022 17:36:30 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z4so1870623ljq.6;
        Mon, 12 Dec 2022 17:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fvZ9dsbTSO5t0cyccsnnRz540B4PzoHkUUU3iPVGl+U=;
        b=WgQoeWydkLJHdlGHP6gVQ0NIsZGb+iP903Y9h70Q2Y2zyLPlvkHC23QVprLR0ayRsR
         hnv2d2eKWl94mrkGGphxPTE/BdzFgZCPLaB/ywq7t6ESd+XGt9ggyRRaypfxw647VOtN
         ElOJwKa2zTFse1Lqr5jfQ7TBDL0P/aYXIBmoNAbuQaT75UWYAOjZMcLCKYrX9WPjyRbq
         ikTbp6iwWsdGzWRWtmjWl1elWwF9nZPrswsokChiAYPt6VdUh8A3rzBUI0Rk35ur0Jbn
         rbQX5Guzkwgjn4D43+XRfXXrqxLwontWolWiiE8BEerqSVM1SR80yBzbvfkDMoLYBWh6
         DtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvZ9dsbTSO5t0cyccsnnRz540B4PzoHkUUU3iPVGl+U=;
        b=bQtnN/exxrEpQtTTzq0+5HwvFpGj8P6EBK3bmdTtdKgsh6w8f0iGiFfKiEQ11R0uzN
         i0Bc5pSvhx+lr74Ip3BvfziIxTcaQTuxHYFjJcOPRAgHe391P0tDfeIzNn4H8m84blfa
         jm9MzsseZyrBoPP7rpUASb6x8XrNz/Ln/UyU1tQQLb9vGeIAHJwjlYmsEwD5G1EMX3AR
         o50/O360F84cRlnHvdYfNxVPNvOqwbVrcjRnOTnVOX8Aaj7SJxf/j30BqbRYNV9FEFp2
         dy5FZkWBUhPqlln3VppqqgrRGHbk9djKxOt72n1zP4pxFIuP+aMpHxNZo36UbD39YRIE
         39NA==
X-Gm-Message-State: ANoB5pngzfyyaNZWjXrf6klXrShTbEf5o2791cRDoYsxnVF9Fu2smiqm
        ZKXA8nSIXgkMmdX7vnyOE6xU6xDo8+bPZz+vcQ==
X-Google-Smtp-Source: AA0mqf5wvwkn6bzo+kHF2Ex75sOLfziqTgDo96h9zXDqPU6XFguoZFVG9koMv9TLZBI5+I3Wc5FTsiJcFynLhHDdlsg=
X-Received: by 2002:a05:651c:3c9:b0:279:ee82:f30a with SMTP id
 f9-20020a05651c03c900b00279ee82f30amr7180475ljp.397.1670895389018; Mon, 12
 Dec 2022 17:36:29 -0800 (PST)
MIME-Version: 1.0
From:   "Seija K." <doremylover123@gmail.com>
Date:   Mon, 12 Dec 2022 20:36:18 -0500
Message-ID: <CAA42iKzuae0PL1qm20sU87D2V-GF8mMFPSjKJu=fB81RrZgZbg@mail.gmail.com>
Subject: [PATCH] drivers: correct parameters passed to strncmp
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>, Jia He <justin.he@arm.com>
Cc:     James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Many times when strncmp is called with the intent of ignoring the NULL
terminator, the null terminator is accidentally included in that
comparison, which in practice is just an strcmp with extra steps.

Subtract from the places where the intent seems to be to do a
comparison without the NULL terminator.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index db672cf19a51..883f3078e233 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -94,12 +94,12 @@ static int __init sr_init_by_name(const char
*name, const char *voltdm)
struct omap_volt_data *volt_data;
static int i;
- if (!strncmp(name, "smartreflex_mpu_iva", 20) ||
- !strncmp(name, "smartreflex_mpu", 16))
+ if (!strncmp(name, "smartreflex_mpu_iva", 19) ||
+ !strncmp(name, "smartreflex_mpu", 15))
sr_data = &omap_sr_pdata[OMAP_SR_MPU];
- else if (!strncmp(name, "smartreflex_core", 17))
+ else if (!strncmp(name, "smartreflex_core", 16))
sr_data = &omap_sr_pdata[OMAP_SR_CORE];
- else if (!strncmp(name, "smartreflex_iva", 16))
+ else if (!strncmp(name, "smartreflex_iva", 15))
sr_data = &omap_sr_pdata[OMAP_SR_IVA];
if (!sr_data) {
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e3318e5575a3..1d832f484f8d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4333,7 +4333,7 @@ static int __init amd64_edac_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (!x86_match_cpu(amd64_cpuids))
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 65aeea53e2df..546dd9fc5cc5 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -759,7 +759,7 @@ static int __init i10nm_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 544dd19072ea..7df2b3a82221 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1275,7 +1275,7 @@ static int __init igen6_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
edac_op_state = EDAC_OPSTATE_NMI;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2b306f2cc605..08aeab382cb4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1532,7 +1532,7 @@ static int __init pnd2_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..6f8904b55213 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3638,7 +3638,7 @@ static int __init sbridge_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 9397abb42c49..ea38449710f5 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -657,7 +657,7 @@ static int __init skx_init(void)
return -EBUSY;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/media/pci/bt8xx/bttv-cards.c
b/drivers/media/pci/bt8xx/bttv-cards.c
index c2b5ab287dd7..c24cc2f46d2f 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -2968,7 +2968,7 @@ static void identify_by_eeprom(struct bttv *btv,
unsigned char eeprom_data[256])
if (0 == strncmp(eeprom_data,"GET MM20xPCTV",13))
type = BTTV_BOARD_MODTEC_205;
- else if (0 == strncmp(eeprom_data+20,"Picolo",7))
+ else if (0 == strncmp(eeprom_data + 20, "Picolo", 6))
type = BTTV_BOARD_EURESYS_PICOLO;
else if (eeprom_data[0] == 0x84 && eeprom_data[2]== 0)
type = BTTV_BOARD_HAUPPAUGE; /* old bt848 */
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c
b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 98793b2ac2c7..795c44656ab3 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -912,7 +912,7 @@ liquidio_probe(struct pci_dev *pdev, const struct
pci_device_id __maybe_unused *
static bool fw_type_is_auto(void)
{
return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
- sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
+ sizeof(LIO_FW_NAME_TYPE_AUTO) - 1) == 0;
}
/**
diff --git a/drivers/staging/nvec/nvec_power.c
b/drivers/staging/nvec/nvec_power.c
index b1ef196e1cfe..3ed9e06e32de 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -207,7 +207,7 @@ static int nvec_power_bat_notifier(struct
notifier_block *nb,
* This differs a little from the spec fill in more if you find
* some.
*/
- if (!strncmp(power->bat_type, "Li", 30))
+ if (!strncmp(power->bat_type, "Li", 2))
power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_LION;
else
power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
