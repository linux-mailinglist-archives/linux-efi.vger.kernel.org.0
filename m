Return-Path: <linux-efi+bounces-1798-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201B986247
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106081F28EA0
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406612CD8B;
	Wed, 25 Sep 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFVz+AlT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C977117
	for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276518; cv=none; b=Mv5AzVzgt8tckZ7MkbQiZTdWChVYt2bNmgNQqbCj7A0be5nFS0q4VvvKkyTaloAURiLnCjBnKbo2wh4oaTZXTQZPFOpigT3aF6IXl1vMb9ZC7eWDfWutiAVM6DE/lkSRCx3D5Dj5wLOL1CystyqaKSqoclB7R9zO83XljVMlYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276518; c=relaxed/simple;
	bh=rk1TLausu3D2x4uz05lRhrdTMxiTSLA2fDl1meeIK+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDcoyVdkDrzQ/p5oNaRlqiFugSnysijWN1fJHM3a5GY/7wYRwU+2GqhZRw88uUkH5NCLhy6NMOFstDmC49VqnQgBYTGSry5qY7yL51sqv/xt9MDza85M7wWai0SqMQKwAR3YnE8iG4+mvWdYGjiNL98rEBfwkXsOIYr81h3zP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFVz+AlT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so63317415e9.0
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276515; x=1727881315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjSReXj8XxN+J1aHSpg+bgY7XO8zJXJrh2uX1BeFRGQ=;
        b=VFVz+AlT0fVj8J3pb0uIJQLGxkYCKkAvLDgcAohPDUXmaMuk6UTbw4uq+CHcsEoRZ/
         5x5aSnW20fDUqHmuY3uMAA6I80/9rPDD/5xGciRxrWzTnMT2UtipActHUBezkRFpEjjj
         sOG059kJtCdOCKA5XBwzrZmIOIa5S/UmblboEdVQKaDLNiR6M6X2DIjGQ4+n7oN0yCPj
         sb6pNNvyVesjn3JTHhpQAoqB4ylt5fKdSAS0LSqxRycl+oVbZWRIh3MrNoaPcUJI0dRJ
         +onoD54UsA3PxnhIJe/kNKf8LKnhjzLE+eMh0qFTJDtNpVvQBt0X749C/T9XvKosb9xa
         ZuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276515; x=1727881315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjSReXj8XxN+J1aHSpg+bgY7XO8zJXJrh2uX1BeFRGQ=;
        b=IeGBh98RloiaDymJ2Bbbi38ZGR4z/49GPLIo1SIH1IOB4pDylZa62eXpSl8TIXgOpS
         6tRZZzCydrfD1IAcWZFdkGWLQoS+uQQi1ZUlSkjla/Q9dqhi3eE2g0iL5cI6PKjtXAQi
         57Jm6EfVygHvUaUA+wMx/Y+NWrfRrsVef0zQPNnYU97oo/6bPJj4Sow7Fd9RnUyY3mw6
         Y7y85++F4Ij2OF69WEON++qLhxjx5lc8sPFtApK8h62xX2VcRZNy6g9Uk6AS45y3Iu3W
         qE39oExV0FzLYqcUE9TWSnWEqv7frdrkx76QEGGhhaK8hkUM0ivb23WgYC4a1V6AT0Na
         NuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOHtC0B1VKTuXGseslV3b8GqwCUHEnJNOUNulnTrvHChRKz98omIjujukGY83QNDablYBq/LLg+F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxytRGw4FWunmanaNUDot9Rm438KDuyStIvdnSCc3zWXQ8LXXgx
	EqLIZoaoUjqioSOaK6MZRBerp+48gIC2Np5VYlHz6aQxxndm2ZUenFwRoph5rdvtNrPv3Q==
X-Google-Smtp-Source: AGHT+IGzIZ2o2YM9LwRx7GUBkPXP1nnHd93bOM06M/lDtcRNJJFbQb+/UGpm4f4GZO5kVPvAO8R9y3yP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:214f:b0:42c:b32e:6ba7 with SMTP id
 5b1f17b1804b1-42e9624246bmr34035e9.6.1727276514236; Wed, 25 Sep 2024 08:01:54
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:02 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=ardb@kernel.org;
 h=from:subject; bh=Etb53DEUMtJxbS45M94XzvcBugumXuKFZ3M2B/KYBNo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6jquDX165ub5J178W1mVH21S/GxP0fqUgljlqYpRR
 x60nEvpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRa2RkeBV2XNd/yacJf4IS
 mc47ex9ud90aJbN1Uf8PDSuxLfrPTjD8rwhuEVogxe0Xov++IjA4keVg55+fz6JEZeM/B04o0/B nBgA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-32-ardb+git@google.com>
Subject: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Bump the minimum GCC version to 8.1 to gain unconditional support for
referring to the per-task stack cookie using a symbol rather than
relying on the fixed offset of 40 bytes from %GS, which requires
elaborate hacks to support.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/README.rst | 2 +-
 Documentation/process/changes.rst    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index f2bebff6a733..3dda41923ed6 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -259,7 +259,7 @@ Configuring the kernel
 Compiling the kernel
 --------------------
 
- - Make sure you have at least gcc 5.1 available.
+ - Make sure you have at least gcc 8.1 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
  - Do a ``make`` to create a compressed kernel image. It is also possible to do
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 00f1ed7c59c3..59b7d3d8a577 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
-GNU C                  5.1              gcc --version
+GNU C                  8.1              gcc --version
 Clang/LLVM (optional)  13.0.1           clang --version
 Rust (optional)        1.78.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
-- 
2.46.0.792.g87dc391469-goog


