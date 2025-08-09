Return-Path: <linux-efi+bounces-4524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B5B1F2F4
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EF3582B4A
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351A21D3F2;
	Sat,  9 Aug 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0I+/Nz6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C72221294
	for <linux-efi@vger.kernel.org>; Sat,  9 Aug 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725979; cv=none; b=hika9vmKL/0RP9JVsoOlpDmf+eG9Eiqwb9R0HmgMrF61F7Ahze+txTW5TZLkXe7FW50XLMsF+azFPk8dhEkkvN/tn647w8XzCYnWfyLCTFg+/LFWknkKcmHgKuH0skd6al9z7pbjvq5uszlnJ3y1a/EcXtQISW6BLdlPkwxfcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725979; c=relaxed/simple;
	bh=JLTYpgPX2gKSDNfEZ/FjVcRjCDil4zVGksSD/Tomwzs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Onex2CegCcAWhxfs+DgaTDvx3O0SHeEK/rCZg/v9l4wSA+wwf3F6Ac/2LNHZHQfUAxgde+P/OSia2qucJI84Q5y26P9gEC2h2AjyOchVQEkQUXi7f0YUkBirhAE/Juqu2a3kTwvIHhzJGE1jgR3ZJ18jUiPA8PpVB0Ue8HOHoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0I+/Nz6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-458b9ded499so18652585e9.1
        for <linux-efi@vger.kernel.org>; Sat, 09 Aug 2025 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754725976; x=1755330776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5CDgN6Q86DRzcWItBd03BvQF/aTnZWGy7pznDzkaL0=;
        b=x0I+/Nz6nW9BoFqywUHx0AjU/UrdH3sKJtA3J8BoF6URqlCFUigQAM+MHx0ydGh/HM
         L+bRC/bOiJzPi7swI3P6jnYvZZhLLGEkniMTX+fPnjhX//k9gvfjfmPG/fsEWGEHVXrI
         SDBJf0pS4Nb3T+QFkUA7xl/Q8lvrx4lcKhTHM19qKfCeJqXgAmh0Qc3xJXBk1TVdczrH
         OYl0mvr1Qx8fuFbd0eyEtFTqEEvkq7kcMeI8aapJxA2ysYDrawEki7dAI5kxY8W13qLA
         G7eTXNslEgIQdgRUTFa5b3rwC1ujAC40+YBk7MAWCHlyNILHLQb1GOn/WKOevHXaL5kt
         9Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754725976; x=1755330776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5CDgN6Q86DRzcWItBd03BvQF/aTnZWGy7pznDzkaL0=;
        b=A6zYuZuu5MdOMskckMDiQFJnO44uhNOA87ta2PWIHNf84RWAoaRWLmRgukStxtOyoO
         EKO6m6eiD6ckfxD9egNYPzXJP7b/cGAUoy/77lM2S76S1YvAO2epkXfJrAR3mWfEL0wV
         T7z+NqO76qUntnjNBxgp7sfwtv1/GDsad1REkhCQ8RazAY8J4T1I/QTsydOD3XL78SSJ
         MF4zCMMNiDMg0zBoAtlDc4K7ClL0Y/6Yg60D22AoGv2v+OlGizJ4x9rAKKnD6SY1h60L
         BPJRqoDqRFRVysPvoJQ7kjY4tuwYTIKPVkPW+GsLirqAIMVRfc+j0UXYHbmNQghhU8P2
         oUKQ==
X-Gm-Message-State: AOJu0YwlRp9E1pzdMCzoEko7QeoGAp0nrdlD2iBEZStO99hgTCJ+ltCm
	qz4ggzyTyMo2Zgug6mUD6f5calwiIqn3rW6TZXAjjiD/6ktkZQU9beljgxI2e4Fbpg7g7CWJ/A=
	=
X-Google-Smtp-Source: AGHT+IE9riWJp5b9dapPptjJZKLyvI/5baGX5w7VVK8s+CJYBPgoMQwFYYeFxGImYcX2lF2dWN3/Mj1m
X-Received: from wmbeu5.prod.google.com ([2002:a05:600c:81c5:b0:458:bfa7:dd5b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:358e:b0:43d:fa59:af97
 with SMTP id 5b1f17b1804b1-459ff56ff6amr2925035e9.32.1754725976624; Sat, 09
 Aug 2025 00:52:56 -0700 (PDT)
Date: Sat,  9 Aug 2025 00:52:43 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=ardb@kernel.org;
 h=from:subject; bh=R/Nb/t+N1S95o6swiyPaTrQ+UIbFaw7fMHuozo4XQ/I=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPaP99za/f8mJiYGmt4Q3yv3PorYc+c3u16xh3V9+9e6
 IOX8UsedZSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJvBFk+GdzhmPxe5V9iQ/v
 dRbaXFT/VSHl2LNVdu+ljLevjFTbIr0ZGaYKzQkJ7rEofT41s76nIfjGprNp7VXLBVbvUPq9xr/ qHD8A
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809075242.54020-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.17
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linuxfoundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Apologies for the late notice - I was on vacation and wasn't aware of your
condensed schedule until today. (And then, the first attempt of sending this
message failed because Google's dodgy internal git send-email fork seems to
ignore sendemail.aliasesfile [1], and I didn't notice the delivery failure
notification until now)

Please consider pulling the changes below.


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.17

for you to fetch changes up to 02eb7a8eee20b9ec6aafd5e17c5c41b53e8b13ef:

  efi: add API doc entry for ovmf_debug_log (2025-07-15 04:15:30 +0200)

----------------------------------------------------------------
EFI updates for v6.17

- Expose the OVMF firmware debug log via sysfs

- Lower the default log level for the EFI stub to avoid corrupting any
  splash screens with unimportant diagnostic output

----------------------------------------------------------------
Aaron Kling (1):
      efistub: Lower default log level

Gerd Hoffmann (2):
      efi: add ovmf debug log driver
      efi: add API doc entry for ovmf_debug_log

 Documentation/ABI/testing/sysfs-firmware-efi |   7 ++
 drivers/firmware/efi/Kconfig                 |   8 ++
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |   8 ++
 drivers/firmware/efi/libstub/printk.c        |   4 +-
 drivers/firmware/efi/ovmf-debug-log.c        | 111 +++++++++++++++++++++++++++
 include/linux/efi.h                          |   4 +
 7 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/ovmf-debug-log.c

[1] https://lore.kernel.org/linux-efi/20250809064606.35568-2-ardb+git@google.com/T/#u

