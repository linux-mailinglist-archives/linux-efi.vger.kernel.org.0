Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787F652FED
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiLUKy4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 05:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiLUKyx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 05:54:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B220379;
        Wed, 21 Dec 2022 02:54:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so14538659wrm.2;
        Wed, 21 Dec 2022 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aklw2jl3XnFdmw/HpIxQPuULWv8N191ETMwU6JhxxM4=;
        b=O9h5bcxY/bmV+lAR+XwSlXBv53dPlAW4s9Aq7AtMfvytWWdahsMhckktzehq0X0A02
         pH9gl/KF3vewZ7tHPnvcwgwXIJWsRC1FSdTJhW+uVwKIxYV3dPGfE3YSQ6Q/sfYmB3cI
         W4IjWOaN0di+U+sPznxUtiuOu3QrZGa1YiEaqz0EzTOC1FEuyZqKKTnX17CWLyndr8Ki
         Id/btXNqTgV2gRvXessrSH0y69tMm35wd7n5P+JSMzOY4nJEJc3ny/amFfBsiWjikRmx
         7kmoHsAyJr9gVP2kD7yirkJYKf6M7ckBp84TCG2m/7pShKaWmtbWTBhvEY1blYaO4/iM
         xjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aklw2jl3XnFdmw/HpIxQPuULWv8N191ETMwU6JhxxM4=;
        b=6YFJ3pglbcSw9/d1gnyZtY7uRmsy++7CacjiWYUbJngOi0lCFD3y/Hhrop5PKMWKcv
         5w43iWZWUYTPi+zK1G1x90wngTSUSULAm5+UlIl+FpYYUFfdLOM1OVgOBZLuivehfHo5
         XMeKoEsHxn8MkTvh19emNEGFZTmgKJ3iN3+vhK64d9Who4RRJb7ZopDCa0OuqCJvVpOz
         FtVI2/ziHvf4Hf784y4cXe3EqC8kmE9IGSjVeSAkWy6NM+8oubSqU8ofrTy7tfmYoyOP
         dIqwzbCDf2CdnjtDeJICCIK7+gd65uers8G12vYmV2HDXGxLXpoEa2F6/wmUO5fPDsDN
         6G0g==
X-Gm-Message-State: AFqh2kqkIIannQuSvbuSpG/hB/q8ImRr0MBssH+xJQ6Qgmdp0YjjRhzi
        LRve+7BLMFtmgx+4Fp1Zw1Tzv2OfpZE94A==
X-Google-Smtp-Source: AMrXdXtV42q/+hey/28X9GdgHrY1kgVulkHepAG10WUtueDz0Unp9DXQRivayHT77v0FoHXtilcIzQ==
X-Received: by 2002:a5d:4a90:0:b0:26c:2061:cf11 with SMTP id o16-20020a5d4a90000000b0026c2061cf11mr670238wrq.1.1671620081601;
        Wed, 21 Dec 2022 02:54:41 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm15080156wrw.53.2022.12.21.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:54:41 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/3] efi: earlycon: move to video/console to prepare for changes
Date:   Wed, 21 Dec 2022 12:53:59 +0200
Message-Id: <20221221105402.6598-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221105402.6598-1-markuss.broks@gmail.com>
References: <20221221105402.6598-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This would make the next patch in series with this one to
show a clear diff, instead of just removing the previous
driver and creating a new one.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/{firmware/efi => video/console}/earlycon.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/{firmware/efi => video/console}/earlycon.c (100%)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/video/console/earlycon.c
similarity index 100%
rename from drivers/firmware/efi/earlycon.c
rename to drivers/video/console/earlycon.c
-- 
2.39.0

