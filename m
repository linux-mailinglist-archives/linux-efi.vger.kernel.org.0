Return-Path: <linux-efi+bounces-3071-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14FA6E0CF
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56002170787
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A86263F40;
	Mon, 24 Mar 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIpntT/w"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2A263C7B
	for <linux-efi@vger.kernel.org>; Mon, 24 Mar 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837346; cv=none; b=Q45DF2XWSFi9aUInVJxvEBDrrF2g66bblHJ6NOl7+R9+P3JA/09m4GR+/M7/65bJtM23zPLIhSpQTIrUkOm0Nn48x1aCsKUjgeFQQNUtjWpudDVpHhRAtoXVTOeGC6Sf+ZKlGhVPEzQUi02g4sJvkPuMZVcXVJ560PKzEdpHGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837346; c=relaxed/simple;
	bh=lP6l4cI7/jGloCIQwt6mXdDSjyKba8rsmfpwRjrO2lQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ks9lH9EUCn2QUHT34eftiWF9TVskheIdBjlQRPubLLnAn7nPEAt20RpP7tcI4JQ/j6wqT25fpNnufZW870F0mGenFz4naI6ta83P+sMXFFoXXCsR3L9LVpQEQ6Kn2/KwWwjp+IyQZuaJ0zfVkaNyxBauIsGTUaF09aNxA8qkjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIpntT/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B47C4CEEF
	for <linux-efi@vger.kernel.org>; Mon, 24 Mar 2025 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837345;
	bh=lP6l4cI7/jGloCIQwt6mXdDSjyKba8rsmfpwRjrO2lQ=;
	h=From:Date:Subject:To:Cc:From;
	b=FIpntT/wRWgzQxyfmNpVr9snt00u0N6KK6UvgIq9GL8LOjGrUzn3Z+udhw3ZFwPMJ
	 Rr2zIWCtDWPPAmCfDEdNstwYJy767n/jFTK6URnje0v/rKDS8HHrZjYfwisff6deQB
	 KoHM0Sobj3SwIxfoEwlsHK1uTFQ7in7VLSt6g/WFxrcd9I7xT2h/kYnZn4WuXvELrs
	 pIkDn4n5cJ8WAgo8R+iK59jzO4B9RDS1k1ECYJ0/2LICl8t/V8uyL+G+YyYRqOym4r
	 /pp3sCxawtQFIPgywoyvTzPJxnAwLz8+5u/zljZqc7Bg4r7hp5gkNapo39M8OZ7p+J
	 kaNyKjThI/7PA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54aef877725so822731e87.1
        for <linux-efi@vger.kernel.org>; Mon, 24 Mar 2025 10:29:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9nY0BokGdfx6qFtHudBStncPnUYAx/IJZscbyOGSudmM0sGHA
	e4e0yPMAH7YDMbkh8KH+PNoIopAU7aWuE8ffS4N/MX8INGcHrfUlwAFYdZunMef885cyYqI8CZQ
	bsKD4z0C2LkobNAs+y2n70ZPHs3Y=
X-Google-Smtp-Source: AGHT+IHNZI2/9BxzuSLiSEzyhByDHAJ9bDhbmWjhVQliAHyE/zuWM/w5c7AolYlRgKpXVeCbJ6c/5Ihqc1ukc6UgWOA=
X-Received: by 2002:a05:6512:3082:b0:54a:cc76:ad5e with SMTP id
 2adb3069b0e04-54ad64708fcmr6152812e87.3.1742837344189; Mon, 24 Mar 2025
 10:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 24 Mar 2025 18:28:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
X-Gm-Features: AQ5f1JqHuy0jgXGLm0D0dSSBfrtBUD7Dxtk2rVg_yQ9adre4qcW8Uu9CLQe2ICo
Message-ID: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
Subject: query regarding SEV logic in early boot
To: linux-efi <linux-efi@vger.kernel.org>, linux-coco@lists.linux.dev, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

L.S.,

As I am trying to disentangle the Linux early SEV boot code, the
legacy decompressor and the EFI stub, I noticed something that looks
broken to me, but I'm not quite sure how to fix it.

When booting via the EFI stub, the following call chain may occur:

setup_e820()
 process_unaccepted_memory()
  arch_accept_memory()
   snp_accept_memory()
    early_setup_ghcb()
     set_page_decrypted()
      set_clr_page_flags()

where the latter function relies on mapping_info to remap the GHCB
page as unencrypted. However, when entering via the EFI stub, this
struct is never initialized, and so I am struggling to see why this
works at all.

For context, I am looking into splitting/refactoring the decompressor
SEV startup code and the kernel proper's SEV startup code, in order to
a) use PIC codegen properly, and b) allow building a EFI-only bootable
image that does not include all the exception handling and demand
paging.

Any ideas?

