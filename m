Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B472CF2A1
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 18:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgLDRFd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 12:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388469AbgLDRFc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 12:05:32 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292C061A54;
        Fri,  4 Dec 2020 09:04:34 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFY3hxlz8shy;
        Fri,  4 Dec 2020 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101473;
        bh=BhwfsW8i5poiqhrHcQPPM45F6TQVBidAbXm20KtAZ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAAIZFLsuSh0DkJBGiv9fBih9vPIGmkBscSf6Tpe9rjJ/dmfZAd4iM92CktR48Xaj
         wbXBLfcVG6zh0atyfWM+gMjIAe0imCJNd16mU3b+aBWUeHwG3+M2aS+EsjMS3ot9hP
         plVIMwVACB/icog29OV2+VIDA31rOlGKOGct043Y=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFY0CYZz8sfb;
        Fri,  4 Dec 2020 17:04:32 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:13 +0100
Message-Id: <20201204170319.20383-8-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
 drivers/firmware/efi/libstub/gop.c             | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..a502f549d900 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -230,7 +230,7 @@ efi_status_t efi_parse_options(char const *cmdline)
 			if (parse_option_str(val, "debug"))
 				efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "video") &&
-			   val && strstarts(val, "efifb:")) {
+			   val && str_has_prefix(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
 		}
 	}
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index ea5da307d542..fbe95b3cc96a 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -39,7 +39,7 @@ static bool parse_modenum(char *option, char **next)
 {
 	u32 m;
 
-	if (!strstarts(option, "mode="))
+	if (!str_has_prefix(option, "mode="))
 		return false;
 	option += strlen("mode=");
 	m = simple_strtoull(option, &option, 0);
@@ -65,10 +65,10 @@ static bool parse_res(char *option, char **next)
 	h = simple_strtoull(option, &option, 10);
 	if (*option == '-') {
 		option++;
-		if (strstarts(option, "rgb")) {
+		if (str_has_prefix(option, "rgb")) {
 			option += strlen("rgb");
 			pf = PIXEL_RGB_RESERVED_8BIT_PER_COLOR;
-		} else if (strstarts(option, "bgr")) {
+		} else if (str_has_prefix(option, "bgr")) {
 			option += strlen("bgr");
 			pf = PIXEL_BGR_RESERVED_8BIT_PER_COLOR;
 		} else if (isdigit(*option))
@@ -90,7 +90,7 @@ static bool parse_res(char *option, char **next)
 
 static bool parse_auto(char *option, char **next)
 {
-	if (!strstarts(option, "auto"))
+	if (!str_has_prefix(option, "auto"))
 		return false;
 	option += strlen("auto");
 	if (*option && *option++ != ',')
@@ -103,7 +103,7 @@ static bool parse_auto(char *option, char **next)
 
 static bool parse_list(char *option, char **next)
 {
-	if (!strstarts(option, "list"))
+	if (!str_has_prefix(option, "list"))
 		return false;
 	option += strlen("list");
 	if (*option && *option++ != ',')
-- 
2.20.1

