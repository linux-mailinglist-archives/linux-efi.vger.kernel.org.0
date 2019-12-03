Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A11105BB
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 21:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLCUOk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 15:14:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44859 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCUOk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 15:14:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id g24so5098409qtq.11;
        Tue, 03 Dec 2019 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hsFoc2grURMCqHJk3/bdURAhFk0iV5nKoNBvEUJuOoU=;
        b=r0oYPeT0dWKW6vbtNpxzFaHkL847f7O2oRZppJeekAmjqhAGscbeuhJcZS4FEXuF0d
         Eivr8nfQXnGZGBhS6iwWfhO/pmXRfRhtz5+3qyoIL5QAKvgOXNPv77T2RzROQnHfG445
         NFrmn9TWNxIJo2eVlLWS54UzF4gOULPWQYyW+DSrLBNJlx2U/wac5p1bZZya0hC8F6y2
         FmaU0ZkOh1AcMi5TYArQyeTDNTtY7RTwT40rMExw5WOsABWpeqCmjAYcrKHff8GDHFPj
         wxVezSv+Oe2IG/6luskAGi/qT2i7Rv3GbfOn3KNbh3Fs5HsGd5w4IPcQa5sIaRFaHCcQ
         7JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hsFoc2grURMCqHJk3/bdURAhFk0iV5nKoNBvEUJuOoU=;
        b=NYcFMIfCaAqa92XPVh0d0zmyqt4LBXhiTqTdQ0UMJNSYClbE++OqmNpFF/GUPjIW5W
         8iyjkxjhXZQsvQpoTLAjYp9r6PGmi/CgjFvMq5MW1K/ZtIIGjj63wiOpaM1jQQJ4Dlxa
         FTN0SdQkf2ODMWPk9Pt2s/51cSlpNQsJS4RmiikG2pt4gWF4RUPq2ixbTtKkzjxBAr65
         o51I9CVch++3athlSiBev1eHgotkxYslqn54H9KrmWwNKTtSs+8wulVPnYGt1BSoJ7mk
         qJPUXWb5TFFAvXlQJi52FrZzpnoXLBogUEB7j1nYAH45xt3Itkre+U985DSWEcfx2JU+
         fVkg==
X-Gm-Message-State: APjAAAU8pbdVZtgWmG/NUmhyfZgv3mKSZpYO/zseN1sqUQ+aN0XQc7K/
        uYGImvw2WQETQl3auNyydA==
X-Google-Smtp-Source: APXvYqydjbtdnetb3atoETs7iRjrH/Ds6KbWS01EyGo87g8Ha5IGxW3sg0uVv6yHnIYgY43xfuVNPQ==
X-Received: by 2002:ac8:4794:: with SMTP id k20mr3159837qtq.382.1575404079285;
        Tue, 03 Dec 2019 12:14:39 -0800 (PST)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id l34sm2437104qtd.71.2019.12.03.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:14:38 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        d.hatayama@fujitsu.com, Eric Biederman <ebiederm@xmission.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 0/2] efi: arm64: Introduce /proc/efi/memreserve to tell the persistent pages
Date:   Tue,  3 Dec 2019 15:14:08 -0500
Message-Id: <20191203201410.28045-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

kexec reboot sometime fails in early boot sequence on aarch64 machine.
That is because kexec overwrites the LPI property tables and pending
tables with the initrd.

To avoid the overwrite, introduce /proc/efi/memreserve to tell the
tables region to kexec so that kexec can avoid the memory region to
locate initrd.

kexec also needs a patch to handle /proc/efi/memreserve. I'm preparing
the patch for kexec.

Changelog
    v2: - Change memreserve file location from sysfs to procfs.
          memreserve may exceed the PAGE_SIZE in case efi_memreserve_root
          has a lot of entries. So we cannot use sysfs_kf_seq_show().
          Use seq_printf() in procfs instead.

Masayoshi Mizuma (2):
  efi: add /proc/efi directory
  efi: arm64: Introduce /proc/efi/memreserve to tell the persistent
    pages

 drivers/firmware/efi/efi.c | 93 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
2.18.1

