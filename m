Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17C2FD96E
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbhATSrO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390085AbhATRkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=eGmZcYGE0h/Y8fXx0KRtSR1jxg/4LWz6TO2YYAQ3TTNz5kpCOZ17z1q63cidN3Rq5qC9C4
        hw53UE7bh/8mzzECZcRarlmJJYtczN1jXOxCb830ORfq7Q2RSSrftTTEIOYAmyAEXgeuK7
        TcZonuhbDNcvm12WmniHPHsBxaWgEYQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-WT4w-_WMOy63MNWG9YnLPg-1; Wed, 20 Jan 2021 12:38:33 -0500
X-MC-Unique: WT4w-_WMOy63MNWG9YnLPg-1
Received: by mail-wr1-f69.google.com with SMTP id z8so11985741wrh.5
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=LUsbTrQ0GimNbiXOEhMOayQsOAqSMEBsM07l2NGEQ6L0xAp0m75U+9ezcnDraksM0N
         bs4SgoqVvdw4q93DRQLtLICWhwFS0W+1SSmpBbLieBIe+PGDQ9c46qQS3Lf6DjHRhdGP
         WagCvTROGjigN+4u6Ky5zvE+pq+UPQSMRNTdADAPmp4QogUdZWCl1pJ5QcaqiLN3UxR3
         6T6Cip0tmD8Qwf68cZn+e9uPnldwCUvJIUHMO9cWsJhkgmAvXoGd6MdMHhcDljL6zDZk
         dVz151d8cHoIG5Vun3DvTcuExTdtPpy26RLGnhCDD6OD0oJhRVgIqKo+uesEbSTZViC4
         B9PQ==
X-Gm-Message-State: AOAM53048pUOfpgLRzG9h8jU30mC4iY19srRN3ruTTF7F6Vv/iu12iMt
        ht4G8E8hSAdmypdwAveBFFf3UC49cwQ8W5FeeJcxL0f1GE5p29O+HeOIMtPLjWdlY/8VfMBYoNM
        LLkJ9H7iiPAAzvck1Ql29
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650926wrq.359.1611164311854;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykIx+mFRDz39bWZUr6EuNu+ftrUmcrlFbF3bvA/9HzFKbHf9ER+LSC2Ppw5dI+TMNMsSLSCQ==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650911wrq.359.1611164311737;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 11/17] efi: libstub: Ignore relocations for .discard sections
Date:   Wed, 20 Jan 2021 18:37:54 +0100
Message-Id: <20210120173800.1660730-12-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI stub cannot have absolute relocations in sections affecting the
execution flow. However, for sections that get discarded at link time,
it doesn't really matter if they have absolute relocations.

Ignore the relocation associated with such sections.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..70e9c7f45d30 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -133,7 +133,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 #
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(STRIP) --strip-debug -o $@ $<;				\
+	$(STRIP) --strip-debug --remove-relocations=".discard.*" -o $@ $<;		\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
-- 
2.25.4

