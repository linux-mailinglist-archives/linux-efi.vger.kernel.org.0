Return-Path: <linux-efi+bounces-765-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E781387541D
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F58283446
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916F1E897;
	Thu,  7 Mar 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDPKKKsi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AC012BF3B
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828548; cv=none; b=A4FcUVjWiqFso0+zNgHeLuih0qzw/NTqt4xmWSENZR4r4S3MEYtL91vOfYMJZUvat/iJGXO6L+4RlOryXbjVtITuFvqAdoKMYoEGES6vvXQV5npe4grHmp6e2Bgzpvvo0U0WQjoSjv9c50bThuyBXMcFdgzSluPxTQdWsXcvfgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828548; c=relaxed/simple;
	bh=RH965VRzhr8fQNSe1irhAYC9UGkxUfC2Asnt2FtFzlY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e2MZ5EGK/E6ITmOIuhMQZklZh+JKUJl165iwTZAR4ys54fWONIWPyiLo/CEQIr46IYZutmK9krnHhlSstaxD5DbecGzTXIhl5mjYgqHuhmj2mjZvdVOgJSg1ahPSRK420N7MElb+WpWSaeeLmOkuMhpsZ75OqpWa+BPkYj7HzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDPKKKsi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609f015e386so16192567b3.3
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828545; x=1710433345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ErjHBWdSSakqn/aHxwHT5BfjRHzEYvqxPc54cCuTPk=;
        b=mDPKKKsiQehhwNxk6DsuLJpKUSpao4kmVFSNRC02kN7AGJFOArk/fLqA3fDkw27Nge
         DtVPvLWjZERPRnch+3fl3NHIlPcqRWlL9yn5pGpsUhXkLEFARrzh5jXsjziUc4v+HBnN
         b8FKDTwqbXQW1/Go74JUVTEl2Amm4o37RN5rUJ/fmvZ4DQamJFHLmd9C0+buWjfDXkOE
         npeOHGHxy6r7Z0cx6dhCX9skIpUBAjQywvv2ez2EQDl6dIb7f5CkdKoVQirZrya8w/Dy
         L85djul5LDEUHSsoUsUIVDttd9j0T1uwzkM604UGWIatEK7IqeJKD7HT68k8ck/qzDg2
         Ve6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828545; x=1710433345;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ErjHBWdSSakqn/aHxwHT5BfjRHzEYvqxPc54cCuTPk=;
        b=HgYnRF2oVK6RCZJXTvdrqjDU01/REESJLLpATvEMx9hoWzcLZA9YzbpZe81foeNSHi
         sUzCCT5hl8SWPBVYxBGFx6K8bdJvudWVpB0Pkr843KEMYSSTTbwMTxtPDpjhSRlS+j4k
         iCCgOrYNWeYJ+mX6JBtMjSF0sjo1Sup21aBGJRhm68WCQRBcjObu9mgyfLiQYn1B9R9l
         qnbPYynPE2X+iFoyMb1fJ0vUadC7woZGgLDCWG4SvaZQx1lqGQvtiMJtjmsvQ6JAEsqg
         z3NIK4/UUIjB8t1Mlg6j2LV8bC620G1wXxhOJnZzdqu0tM9MAoLVzaMTDZ1tViM3OJvw
         rnBw==
X-Gm-Message-State: AOJu0Yxe9oMhE2EL0K+gSXlekyWU7WlCsI7I5FRKejzhAUme69ikLFVC
	DNkVEDJqoZLWiwWGRoQLe9PxihSDiEcLeNJiSTMlGK0Qg6ZAkagkutjqx/ZjUowtU/oPWcINXrP
	Q8Md+O8cPX47HkeeUo4YoPkl+naApPESnAU2SLvTUNRahLaUPjOga882CAMREWQvIATIvCk4SBj
	RZGVTcusVW7rWBuFJd5N+Rih/3dQ==
X-Google-Smtp-Source: AGHT+IFQeZzccCYpyXrXt2CDmITr8E6OB2I0r0qghDPijJgHKVU/DBgUqy3n0Uu5uqa9lUJlwCOc4VcC
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:d696:0:b0:609:e89c:983f with SMTP id
 y144-20020a0dd696000000b00609e89c983fmr883274ywd.10.1709828545472; Thu, 07
 Mar 2024 08:22:25 -0800 (PST)
Date: Thu,  7 Mar 2024 17:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=ardb@kernel.org;
 h=from:subject; bh=tdmSSd52DnAz994gpQ6l+sVS8T+KwMjSwhjTlMziEmU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXly+3fPuzjX3RbeOqN2i7/a7cV7jW58J0z+yHwfVLaj
 bjrvx+d6ChlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQAT+XSekeHQ8cpZP15+PfBj
 77k/c7I3TOv0jQoPCG6a2MHHKZCYHM/M8M9ghnSp1eU7p7v6WM9F1rM1bH6xV71O6q6UrZXegly BlfwA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162214.272314-7-ardb+git@google.com>
Subject: [PATCH v2 0/5] efi/libstub: Fall back to CC proto for measurement
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to Kuppuswamy's series [0] to add TDX based
measurement of the initrd and command line to the EFI stub.

In view of time wrt the merge window, I've taken the liberty of applying
my review feedback to the code directly, rather than going back and
forth with the author to converge on something we can both agree on.

Changes since v1:
- add patch to switch to the TCG2 spec's symbolic GUID name for the
  final events table
- omit flex array member in efi_cc_event_t
- avoid version confusion between CC and TCG2 both using version 2

Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

[0] https://lore.kernel.org/all/20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Ard Biesheuvel (3):
  efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
  efi/tpm: Use symbolic GUID name from spec for final events table
  efi/libstub: Measure into CC protocol if TCG2 protocol is absent

Kuppuswamy Sathyanarayanan (2):
  efi/libstub: Add Confidential Computing (CC) measurement typedefs
  efi/libstub: Add get_event_log() support for CC platforms

 drivers/firmware/efi/efi.c                     |  3 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 98 ++++++++++++++------
 drivers/firmware/efi/libstub/efi-stub.c        |  2 +-
 drivers/firmware/efi/libstub/efistub.h         | 90 ++++++++++++++++--
 drivers/firmware/efi/libstub/tpm.c             | 82 ++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c        |  2 +-
 include/linux/efi.h                            |  5 +-
 7 files changed, 214 insertions(+), 68 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


