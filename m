Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C54C501A
	for <lists+linux-efi@lfdr.de>; Fri, 25 Feb 2022 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiBYUwO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Feb 2022 15:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiBYUwN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Feb 2022 15:52:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004D2028BA;
        Fri, 25 Feb 2022 12:51:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DD8F1F44C;
        Fri, 25 Feb 2022 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645822299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2XvDcM8YOYz/VUNaYX8jiMEFs9ojmeNsJn6nrjEuyM=;
        b=06XkM1h2jd35HkRX/acDRdvzPNnk02benHoaKaKMRtyyPxUva9DM2tRBSRJwyIL+QMBEGL
        VL1BPZubuIoqOJ2cEKlSA7jqnKrgdvkd9NChFmSG340CxvZmPqg/bWyydDsEzMU5aOmf88
        CpYO7qjSszPsjJmoDh89Fr81OTruIKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645822299;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2XvDcM8YOYz/VUNaYX8jiMEFs9ojmeNsJn6nrjEuyM=;
        b=sYsD+vMoBk5i5p1DpUIelO6X7NTIYmwqFdAS1E4m3rp70EjsweaH1hRoAQq70I6nS5QNmI
        u6cEoiSVMAxhctCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 18529A3B8F;
        Fri, 25 Feb 2022 20:51:39 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 3/3] efifb: Remove redundant efifb_setup_from_dmi stub
Date:   Fri, 25 Feb 2022 21:51:35 +0100
Message-Id: <7416c439d68e9e96068ea5c77e05c99c7df41750.1645822213.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efifb is the only user of efifb_setup_from_dmi which is provided by
sysfb which is selected by efifb. That makes the stub redundant.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v4: new patch
---
 include/linux/efi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..0cbbc4103632 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1329,10 +1329,6 @@ static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
 }
 #endif
 
-#ifdef CONFIG_SYSFB
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
-#else
-static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt) { }
-#endif
 
 #endif /* _LINUX_EFI_H */
-- 
2.34.1

