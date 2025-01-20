Return-Path: <linux-efi+bounces-2689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C55A1687B
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 09:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D03A1B68
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9271974FE;
	Mon, 20 Jan 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHNMirjv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A619580F;
	Mon, 20 Jan 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363304; cv=none; b=A0LQ2Ga99j8vlYQMz0u25MN4tKr7WszWN8HjoWro/gCd0MW0wYKqcoguC/+OVpPxll+/tQMhC1wXJMe3UqEelo1UMoSOwlJNWKlZjL2tbFskNmsbistBzVoxK/yz/FRv7gE8vStbi6kNQkcyjibyvCbOAumq172igumrF5TVFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363304; c=relaxed/simple;
	bh=aUQa1IOnKKTxsOlvQHfO0ke1Z7PbRIAe02bVnw4B0yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuUNhPUprq+n7+52fcYxmlBydRiZ0SA8yBzYU/+yotbnoL4Xcdgbf3UdP4h9m9SBA0+/oZo20g3WjKyy1r6toc23/HnfsXINyX5zNnNFqI6uC4eBoz0Gdu1XS1MZmlxNgK5fRBHrRQlR+smsMrVsfAb107tuWAIhK9t0hEx/Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHNMirjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04D5C4CEDD;
	Mon, 20 Jan 2025 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737363303;
	bh=aUQa1IOnKKTxsOlvQHfO0ke1Z7PbRIAe02bVnw4B0yQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WHNMirjv7AMyCJM0ZuFTUbXF9izCXi2zYlJemSMzbyYey7TiCJgJobfYAYXLzf/ID
	 6y5bEAGj+qa9qZvodHrerhUtGlGlqu/80be/YdwTxMZvNVUzQBCQTOutrT/s6PJxJ+
	 oyr1+bTw2tCXEmfRW/f02dE+ZU8869KyCmFXNYXrIycSikLPlpOnuIjZVxcW7l5W9K
	 o14ALmeuxddCmzX/3Hu/KEFPbuV7XM7XuJA0Doi2D05kDxiJSwc/A8UHqwZjSrk+Zh
	 lBoSHRH7LANNZRC/01QGhPZGzZCzrzOC0mhzYDs2p8li+udRd7vmV0TSHkMg3b3eDR
	 HCD9vVkChiVJA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30036310158so36434161fa.0;
        Mon, 20 Jan 2025 00:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIuxiR88jREsPnEQFtwF7lf/CszC1h7EXy/ZwxwmOFMSviKwI2AiXCXAnl+8Ria5A268W9RsQU68MRS/1W@vger.kernel.org, AJvYcCVpLMa2YZe3HNynHCY9JTFVPNyKKiMiZI4TMPPt/WIrzrJSnRo0OI/vGJNe353TjzvCxtevk08xi7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyff/07VTN/1K1nicMUCtMlHd72kekjHMpVYRWQpVKy7AcV+Ctq
	k9f4688CEo4u4ediG8HnRbPyT7sOzkJ2KKY+al9e3tAAP2bL+rpETsIm3J8czaI5H0r8pTriSLG
	Uff8S4+rEqvTrsHz64r5cZOY339Q=
X-Google-Smtp-Source: AGHT+IEo7SdCHzN9ChF5mvAGXLhxKEhs2agvQyabolb3FBwPaBjQEw6eH5YksL5hYI3VRGXxZcWhNCAr+6s/iBuG0xs=
X-Received: by 2002:a05:651c:49c:b0:300:329e:23fb with SMTP id
 38308e7fff4ca-3072cb3f0bfmr40052691fa.34.1737363302211; Mon, 20 Jan 2025
 00:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXEeJattXAkvitfyu3KRRokkSMJZR0xgg_+DG2Mk-tMuoA@mail.gmail.com>
 <20250120085243.2990309-1-linux@t4c.dev>
In-Reply-To: <20250120085243.2990309-1-linux@t4c.dev>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 09:54:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFKSrVx4SO_T8sHU=4hie8pjk8CUWQDV8oh+bz=xMn4rw@mail.gmail.com>
X-Gm-Features: AbW1kvYjRw0h1jAXh-RMwRQpkAcMDsQr1hiyjygvnt72AV8FRlKRubGOUbq3_yM
Message-ID: <CAMj1kXFKSrVx4SO_T8sHU=4hie8pjk8CUWQDV8oh+bz=xMn4rw@mail.gmail.com>
Subject: Re: [PATCH] efistub: add efi=quiet parameter to selectively silence
 efistub alone
To: "Hendrik 'T4cC0re' Meyer" <linux@t4c.dev>
Cc: linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 09:53, Hendrik 'T4cC0re' Meyer <linux@t4c.dev> wrote:
>
> > I'd prefer to just raise the verbosity level of those messages instead.
>
> Agreed. I'll send in a new patch setting the verbosity of those messages one
> above the default.
>

Actually, let's do it the other way around. Does the below work for you?



--- a/drivers/firmware/efi/libstub/printk.c
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -5,13 +5,13 @@
 #include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
-#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <linux/kern_levels.h>
 #include <asm/efi.h>
 #include <asm/setup.h>

 #include "efistub.h"

-int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+int efi_loglevel = LOGLEVEL_NOTICE;

 /**
  * efi_char16_puts() - Write a UCS-2 encoded string to the console

