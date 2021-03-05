Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5D32E50E
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEJkn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 04:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCEJkj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 04:40:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B61C364E5F;
        Fri,  5 Mar 2021 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937238;
        bh=F0bYNFpWstZAS95vOz6HrVlf7Tbzvt2ApyuPiWHyM4I=;
        h=From:To:Cc:Subject:Date:From;
        b=RKKyv8BNfgB5jqbaD8lADiUIOzUFooESKFK1PPO7cZo2lm1NMZ3QvrpQTn7PTLiCH
         GdJqp+wK5VLlfszYyHh+tAMa1ndF5N6A+2euBaJtqq76q8izQHZouMyvKNcY7AxfYI
         JLdIQtDn/WAYlOHZCTvKFdU3PPlgFSoEI548J9fRDzhoWyCwnK2wTj1gnCUaxRjThj
         kNbgu5XoxG8JaWIibrby2KSFvZNc1LU4MaybEEXOT5HzF26zkt6urNpQGjzpGyTiCD
         YBwY/cXl5hpQKmxSxpyzfu9kFbNb8xj2dHJ4fdLAepROWHlIGq1ItWodFZ9RaJS7YX
         9bCXR0OFg1Dew==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/1] use RT_PROPERTIES table to implement efi=novamap
Date:   Fri,  5 Mar 2021 10:39:57 +0100
Message-Id: <20210305093958.187358-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch addresses an oversight on my part when I implemented Linux
side support for the EFI RT properties table: SetVirtualAddressMap() is
itself a runtime service which is only callable at runtime to begin with,
and so the EFI stub should only call it if it is not marked as unsupported.

This may be useful for the Snapdragon EFI based laptops, which already rely
on a special EFI driver to expose the correct DT based on metadata exposed
by EFI. These systems ship with a broken implementation of SetVirtualAddressMap,
which is currently being worked around by passing efi=novamap on the kernel.
command line.

After applying this patch (which I intend to propose for backporting to 5.10),
the same can be achieved by exposing a RT_PROP table that marks SetVAMap() as
unsupported. And while at it, better mark the variable services as unsupported
as well, since they don't work under Linux either.

I'm open to extending this with a Linux specific override value kept in a
EFI variable, so that platforms that cannot support DtbLoader are able to
implement something similar.

Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Cc: linux-arm-msm@vger.kernel.org

Ard Biesheuvel (1):
  efi: stub: omit SetVirtualAddressMap() if marked unsupported in
    RT_PROP table

 drivers/firmware/efi/libstub/efi-stub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.30.1

