Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F102121009
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2019 23:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfEPVcb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 May 2019 17:32:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfEPVcY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 May 2019 17:32:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so5017497wmm.2
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2019 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icfnX62uLR7atIF4Bprs5XNUI1SninhMooqCIwBFQ0I=;
        b=gfLcvu9QQ0v3Z3TCts+0DL0ESMO5gGwHEDInRZoi0kDcLwWSfp7IteoTs7+jx93qUe
         ls4xk0U5bCZfjsKG8Jg5WjGFVXNf52GMUQcHyxVXeMMabjDMfb79+D8SzQ33CB+5YY2y
         V1yvTaM62gpqbjviy73pqBdnd2v0gh0IOAQyYVa37A/7I1chFAv1CmHE2PzUyuG0+Y+8
         yKUuQjzyVIxwtDMGAcyHuLWRMDSi7/IPJjNPMfSXJthXBol88Dvasn85rFGkBquoB79b
         xCbHS2Ccr9PxqplatDrdkwsq2EcY7DkM7GaHXCVxGJpPtMWte9SaYCnVCP5aUoEYucWE
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icfnX62uLR7atIF4Bprs5XNUI1SninhMooqCIwBFQ0I=;
        b=aU7IJ3gg7f0H2WdgBnZh525UtTUzAjxLtotGTp/VNqBjY4Nmv/yO4g70nBL8uGLTRa
         vK9iHcrG9J5diq+k1acfwQP9fhiOYujjiVh1jHnZu0p6uhUg+4Fy+ak38PccBExPwbNv
         /vBfH5pojg2AM4z4EobTliuDInV7kiEheDK+qS6/am2oNvGNWXUG/d64roDP1lvRdK5f
         vgeVJLPx02h+AgaMxbvfa/GzJO2QB4F5P5kuSADI3bKswvgjUXBzyfHlbHlHWfkC1BaW
         Sp0dLfinyHvkDLy0L/GKzXC9PE54mvOuEOwCoeM2rKZ9F+MzKMIkoyzePJ+qY0IX3P1E
         vTOg==
X-Gm-Message-State: APjAAAXLrA8dn/MxQ32c3UPBc0/KsJJv/uLS7Ylk1C+KadkG6vhDar2h
        eOyEqywdqZ29Bzvc4dHkhRw2GZpuS6HUVw==
X-Google-Smtp-Source: APXvYqxCeDpux425AwKFwb/v7bielRInDS2uIWkDtMqFiIqV77kzXUskCUiZRbR4D2Et2VloWDQm0A==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr23637458wmj.112.1558042342021;
        Thu, 16 May 2019 14:32:22 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:55a9:76bd:5bf2:be83])
        by smtp.gmail.com with ESMTPSA id e12sm6756988wrs.8.2019.05.16.14.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:32:20 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [GIT PULL 0/1] EFI fix for v5.2
Date:   Thu, 16 May 2019 23:31:58 +0200
Message-Id: <20190516213159.3530-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit a455eda33faafcaac1effb31d682765b14ef868c:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2019-05-16 07:56:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 7993a1d12c712a3e2cce8e334dd1a4ab8b93128e:

  fbdev/efifb: ignore framebuffer memmap entries that lack any memory types (2019-05-16 18:25:41 +0200)

----------------------------------------------------------------
EFI fix for v5.2:
- ignore bogus EFI memory map attributes for EFIFB region

----------------------------------------------------------------
Ard Biesheuvel (1):
      fbdev/efifb: ignore framebuffer memmap entries that lack any memory types

 drivers/video/fbdev/efifb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
