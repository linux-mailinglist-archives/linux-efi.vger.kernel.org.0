Return-Path: <linux-efi+bounces-811-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEED879AD4
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6591C223BA
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37285137C24;
	Tue, 12 Mar 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asB1AKGp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D3273FC
	for <linux-efi@vger.kernel.org>; Tue, 12 Mar 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265934; cv=none; b=d8XR0DMN5xOU3wd+9oXTl7HB+xjZPiWrIPbzh21X4EgXs5gBSOwhrk1AYTwnG4N0yol/bYtu4rETc91vnS1XynSRQqeUfThS5mSJMJSPqJw1iGijPnHm9SgI413AC/uWn/aM+QSI5J8En1RlOtR5CWPonpRz+eXY3dQ9H71qG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265934; c=relaxed/simple;
	bh=E96RFgKlfXV1du9K86FpWA34QrNJN7+dAaBLx0vsuIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q8T938VPbV/6CsYTCk6ALTsGAJoDRv9xj18y6T9vG8RIXa7TdLVSq30YPVvGCfArRS8NH9oBWsoP0xLPGJKiOHw0R12KRVi1HLPa65cxeA5fdVu4jAlBtzYP9mqW4gTrugqNpjbKjCP5HDAYo7ng8CG0r3OyMzvjpuXQ7BmpkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asB1AKGp; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33e95458c42so1405791f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Mar 2024 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710265931; x=1710870731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDtxe4RWcALKWFoA0LMU4jpR4rZQTWJcn1XZld1M8ZQ=;
        b=asB1AKGpek7/PQ5buDqu3/lNKYhZdlr3qibgp+j/q8c6tCuBSPcXULPQzB5pnfvdCl
         8DFDF6WeZAEHcLa5qDPqjtPAT4+GiJfsgN48paNutRifSnTT71lWFwpIPUOTL1JjSCeA
         9v//7KW0M2bmvlX1pztxODqSZ9o3Uj32XATBip/ZNwsA4+BAGXM79RW7+CyEeMzeCfe6
         SRo23dTz70Ibhple0lpRenVFwmaeuy/ywhDH+TLMkydTW1Vz0/KXfWnZuGA3bwNNtDEA
         jMVjZH+VpuQm1d3nyps6TpFrR8050lGcEU/hnZot46CQmZXIQ2RkvLNZOXoOEA89x7h2
         LIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710265931; x=1710870731;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDtxe4RWcALKWFoA0LMU4jpR4rZQTWJcn1XZld1M8ZQ=;
        b=Ml2caMGDnAxknyBjY7UZKYJsQXcm7bMZxwBRy73GAEvvqt4IetdOsfNWT63qzabe7E
         QR7EYEHnB+VaWq8ZeVw6W68bk6e74L5dRyABsdNn9sMddMizIlt+MO4+Oboj/yK9NXuN
         fsDx5GbjhUl/QTjhV8YElvJME5t8NfH1I25HjLDXsrA24174giFaoXD/nJzPzut7B6yb
         kWyaIYhqKTegNYdyQ3bEIhtgdwf/Rg6LUPbyl4l1Bp9lFGgRtEuB//rMz7sIIX9zhTs3
         D7fuKL3G1TYpmNZo1oQ/03Z/7/eJJmbqyLXZFw2C0GED2UAbqB58eeKBEUPntG52KfhL
         cZKA==
X-Gm-Message-State: AOJu0Yy9DGeJy9ZAflS4oYzvESYjQk1lmG3uu1DjOSmjm5YF6iOyixK7
	XZkhzOP0jyor9UMpjgWNhajKNM4PR7XA8pCCVNU7EAcXPlQRSZVEgtgsJ2vfZ4NdWq6tMA==
X-Google-Smtp-Source: AGHT+IGkK+iQWesBR//EXwhXkQnKi79ufjMkR17H1LMc988Q6K0cR5twOeUZ1A2VT/Vnmi1UnG9XirxX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:9d84:0:b0:33e:8fb4:f3e2 with SMTP id
 p4-20020adf9d84000000b0033e8fb4f3e2mr444wre.9.1710265930657; Tue, 12 Mar 2024
 10:52:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:51:32 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469; i=ardb@kernel.org;
 h=from:subject; bh=HnX1VFD8KWpl1LBkk/A67CzySVreW61PBdOtvKF3Fl4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXDNK0E4dJ+2bJJrVb/Rfc53HU965c9b5GA+CrmN0U/c
 0y4JLg7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESmrmBkOLn/k23FpaZjv3Y/
 eaZ0I8+u8KBu8Bf2lIVKUZev1k9KaGFk2OvZIssssoPjuEnisoDi8+lFTfUfpNbwSjBHfJ6yZuN DdgA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312175137.2185208-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.9
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI changes below.


The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de=
:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-f=
or-v6.9

for you to fetch changes up to 021bc4b9d7ed8dcc90dc288e59f120fa6e3087dc:

  virt: efi_secret: Convert to platform remove callback returning void (202=
4-03-09 11:37:18 +0100)

----------------------------------------------------------------
EFI updates for v6.9:

- Measure initrd and command line using the CC protocol if the ordinary
  TCG2 protocol is not implemented, typically on TDX confidential VMs

- Avoid creating mappings that are both writable and executable while
  running in the EFI boot services. This is a prerequisite for getting
  the x86 shim loader signed by MicroSoft again, which allows the
  distros to install on x86 PCs that ship with EFI secure boot enabled.

- API update for struct platform_driver::remove()

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi/libstub: Use TPM event typedefs from the TCG PC Client spec
      efi/tpm: Use symbolic GUID name from spec for final events table
      efi/libstub: Measure into CC protocol if TCG2 protocol is absent
      x86/efistub: Remap kernel text read-only before dropping NX attribute

Kuppuswamy Sathyanarayanan (2):
      efi/libstub: Add Confidential Computing (CC) measurement typedefs
      efi/libstub: Add get_event_log() support for CC platforms

Uwe Kleine-K=C3=B6nig (1):
      virt: efi_secret: Convert to platform remove callback returning void

 arch/x86/boot/compressed/Makefile              |  2 +-
 arch/x86/boot/compressed/misc.c                |  1 +
 arch/x86/include/asm/boot.h                    |  1 +
 drivers/firmware/efi/efi.c                     |  3 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 98 ++++++++++++++++++----=
----
 drivers/firmware/efi/libstub/efi-stub.c        |  2 +-
 drivers/firmware/efi/libstub/efistub.h         | 95 ++++++++++++++++++++++=
+--
 drivers/firmware/efi/libstub/tpm.c             | 82 +++++++++++++--------
 drivers/firmware/efi/libstub/x86-stub.c        | 13 +++-
 drivers/virt/coco/efi_secret/efi_secret.c      |  5 +-
 include/linux/efi.h                            |  4 +-
 11 files changed, 234 insertions(+), 72 deletions(-)

