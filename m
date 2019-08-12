Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9588993E
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHLJD7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 05:03:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42823 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfHLJD6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 05:03:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so7172996wrq.9
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oQqv3HKn5X9fi3n7gSw2yD56p7It536oUztZrAky7F0=;
        b=XT/KAgcVKFFCQth007TWwBNO9LWTZQD3fCd6fX1J6a75gcjK89Fy19ldAtXmIxlRpd
         1fo0fGubHLj/kW7BowE3h4ZmKDZ7XqMly+O78bFdxAWKIWN/y1+qn0I2C/ntS1uu9kcy
         Z5iO6k0pxcSvZNQhmFTaaKw3/4pcpXzWGj3mJZLX+aXuABabDkZ8ISfroQzUbX+INKso
         85Goz3nFgtfYp+43Q99OHrkIeXimEDGV7kDda8YREVAVa5d9kW0kzmbkJOzYrk3eK9Dj
         QWfIBAW7aWpI4SJLUmTY5/L3X8FDh4utCSMTRTr/nAKIBZzvQgBBfRrbDUsqeAhuZMY7
         0Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oQqv3HKn5X9fi3n7gSw2yD56p7It536oUztZrAky7F0=;
        b=ioRnVaoJqdmKugF6HRcWgIgDL9DIdiZhuDFxnyS8f1cV/Re7Sp5pxy/EmQzAHtpmMU
         j1lqaYAkrwEuMnS1v6f3093SDFwL8F8ir0Cfa42pMS+HbHONkUf7wRZip0aZaGW9Zpk3
         7ZMYkemxhugGfxXwqNH2Nr5+mJkUTHiVw1J6EKCZxUxE4U3xYwSi72vPtRWfGxAikpcy
         wT1r197I91ZTAKm0Gcq7wZgrkvXwF+wecpmNZa+10LOd1Ha0P6j73K6YqyO4UHypG9Zm
         98dihzJTlvvhDPqONvAYawDtqFb07dn/2oJ0INLtKxjKtlfJRykIMxVEuTfy8e2svYgF
         7WtA==
X-Gm-Message-State: APjAAAW3g0iKjHaAvgzJRFScU6T1G5dJxp3uiAgE2P1Fk3OEaJtTUHRS
        fh3LHNg1zjbIONUxpVo/2LAGrdTHKyAQCw==
X-Google-Smtp-Source: APXvYqw/vNb8GyWF413p/M3Z6GK+ZIDq7ow6/dzuSJIrUUiOZe3IteZqK0lpv+/L5yonOVy4ngkPSw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr37792391wro.337.1565600636610;
        Mon, 12 Aug 2019 02:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id g8sm12659927wmf.17.2019.08.12.02.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 02:03:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [GIT PULL 0/1] EFI fix for v5.3-rc4
Date:   Mon, 12 Aug 2019 12:03:29 +0300
Message-Id: <20190812090330.5779-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2:

  efi-stub: Fix get_efi_config_table on mixed-mode setups (2019-08-12 11:58:35 +0300)

----------------------------------------------------------------
A single EFI fix for v5.3:
- Fix mixed mode breakage in EFI config table handling for TPM.

----------------------------------------------------------------
Hans de Goede (1):
      efi-stub: Fix get_efi_config_table on mixed-mode setups

 drivers/firmware/efi/libstub/efi-stub-helper.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)
