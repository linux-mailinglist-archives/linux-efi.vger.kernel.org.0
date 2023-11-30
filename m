Return-Path: <linux-efi+bounces-105-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADF7FEC61
	for <lists+linux-efi@lfdr.de>; Thu, 30 Nov 2023 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148791C20E4B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Nov 2023 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680C125CC;
	Thu, 30 Nov 2023 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIhyey0s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0910D0
	for <linux-efi@vger.kernel.org>; Thu, 30 Nov 2023 01:57:27 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-40b3dae2285so6087115e9.2
        for <linux-efi@vger.kernel.org>; Thu, 30 Nov 2023 01:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701338245; x=1701943045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j0vRBiXJW+fHDvXV5DoctcaJO62O0DHfo9h02vIGwpU=;
        b=BIhyey0sZJuiN60x9NS0EXlsWbSaXGaLNTXRSFPTRw2vrFPET5XJ4gE/y/HzUAfaAy
         7ZhlEA8kCbbx51YXsiSY/q3MGtdCBqKBYfHkf7DE6bDk1bzWFhN0DkIFZCenoxtnVHLI
         mHfE7KnmJ4grroCD8IR6GZLH31VRiGi7hHIWUqg4FGjBBaEsUeGXq0KMBXxy23Zdq0lD
         SBCp3anWR0roQ1hMoOIemtHxW+z83SBLFIdIi5TTpTANbS9v6S5gfF5r1Ku4FZCRAyNg
         fywP9f2/v5jkTjWJk7AhW/iq1VaXkLnww8wWVoZS8ABgX055d/JII8pdtYKe7Wy6GNW4
         NhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338245; x=1701943045;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0vRBiXJW+fHDvXV5DoctcaJO62O0DHfo9h02vIGwpU=;
        b=ipYzXeX9o4dS8aFJnqiMsUInNHvBmgPuQVSIFBR2pDEQ2bza6dISdgTMFds7Cn05nr
         iNTqBoLMp2MtSei9evJUEMZnxeCHdbwoUuYqdS11+iySJA/gfBKPB4c3rMW5IJxGXFDl
         B4f2vG+xE1+mySprEg3oHqgMX2vhXKOoxor7S/TduoHRzsvdjeblA4z8D9hQTh84CZtC
         VbQoL4HVbxTYFiQjRhoXHf3VVJNrj5Zjb/7JvXKQu4l67TcP1ZfVSIiK+tsSzMNst/dt
         kZ29PsfZQqJCWXyBR3/jcfQLq0Sz7wI7teX3bNZcx09pV+vzxhTfsOr399i3KY2bBd2K
         clVg==
X-Gm-Message-State: AOJu0YymOJGBonuhNLAUd93YCJ168P9aAN1za7GbaWafDccAYxblf7fd
	g2xPpJmHaFVmLqtLWxq2wRfMG/sg
X-Google-Smtp-Source: AGHT+IGDrlhV5xsmib4nqniCV0K9Ge1oOCcs58aonkvyyQLkE50jwltCxH7wfhDzZflbTzbJ6s07AHz7
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:4686:b0:40b:385f:4274 with SMTP id
 p6-20020a05600c468600b0040b385f4274mr395499wmo.0.1701338245673; Thu, 30 Nov
 2023 01:57:25 -0800 (PST)
Date: Thu, 30 Nov 2023 10:57:19 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=ardb@kernel.org;
 h=from:subject; bh=rpSRrq0TMBiCpQDv+9H56nC2ViGE03pjpGaVffuuCbc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JITUjpt7vHdMu1ecaPd0vjScfVE021eS7c6652dFbw0tGb
 NbR6zUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIWexkZfrj88P40RyE6dd3J
 5ZUT/F6e+yn2sUvU4sCVDx5nPT2rPRgZXp0PklbKPnbjQ9uMzSWZHyTPz4hd1eW47nrpVbN1lxu kOQA=
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130095718.3985492-2-ardb@google.com>
Subject: [GIT PULL] EFI fix for v6.7 (#1)
From: Ard Biesheuvel <ardb@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI fix below.


The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-1

for you to fetch changes up to 01b1e3ca0e5ce47bbae8217d47376ad01b331b07:

  efi/unaccepted: Fix off-by-one when checking for overlapping ranges (2023-11-28 12:49:21 +0100)

----------------------------------------------------------------
EFI fix for v6.7 #1

- Fix for EFI unaccepted memory handling

----------------------------------------------------------------
Michael Roth (1):
      efi/unaccepted: Fix off-by-one when checking for overlapping ranges

 drivers/firmware/efi/unaccepted_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

