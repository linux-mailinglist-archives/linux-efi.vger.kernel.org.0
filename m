Return-Path: <linux-efi+bounces-4240-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F1AFE5C4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593F217F368
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5A257AF4;
	Wed,  9 Jul 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5+zzGfS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631B226173;
	Wed,  9 Jul 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057193; cv=none; b=dcuqqnyNKnfpwktxoNnobwX0lNDGCsNEOz+cZm9x3GZFkbKCBBJ3NpvZKoafEhpGhVYG86TkNb0s2+EANOenLRWXMhsEFJXVE7q7w9IprhPqyuNqle18mpsg33hIKsQqaOspZdVrNPUxgPbaHV0FHpeZ7XheVHrpwp64LiSZLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057193; c=relaxed/simple;
	bh=woTPn6/m3kkrUf0Kgr7Rngw1F2In5xe+sDP9nL7A5rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePaJC7wbmzueJ547RZSptDNmi6RFe9U/3ZKnLt938fGPS/G9OddbGV1QIXkiMz3a0HRp5dZlT3kXme5ADDDfJrWMLhCJs5Xhhk3dhro7tOpkME703XZOqb/uVejUs/kpHxPIi2wQH548Fpg1KXpcDjjva26X6Fd27jE3UlWrGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5+zzGfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9B2C4CEF4;
	Wed,  9 Jul 2025 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057193;
	bh=woTPn6/m3kkrUf0Kgr7Rngw1F2In5xe+sDP9nL7A5rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n5+zzGfS/SNey1nZVLtQ7oyQf5P8mW0sbb0QyyVSiCyxEzFGy9FdI1JoIwSOvxvgd
	 eYlBNU8WxSTbIEOYNlfj4jLhte9FKDoCCYEx68y1dNKW+08stlhjtqq8qWUFODQ9HJ
	 6ECYYRdykvZ74mR2jkgKYk6A8tRLOSswd0nk3RWKeTxM4Xbc4TG6mCkyctQz5PWLHs
	 kvHdK+AyN9Yd+mAROnJbyX+EdfSB4zvKuAX6zkNIXG5eJX1ADE1+ERCHbzY+OBh6Y9
	 KFJ8E+iVqEcr0AOkEKdUM1tLbaytnTN5nfrTy+cPJYa1UG69TZtdsEg87OIActslOr
	 I59bjQtwRdlFQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54d98aa5981so7241194e87.0;
        Wed, 09 Jul 2025 03:33:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBhd4c0EL05Nte4A32ofGuZLcXw7tIknh1aUKbj5fGDBpfDLguK3LEwDY78nlivKOLZD+qHOMeI/Y=@vger.kernel.org, AJvYcCVIwjKvnis7Ep4cOor94y5AE/DUFBr/sX1WpPMWVhWFiVEs0gvGHzBz6SVICCmgZf0u1LHttr9rprtn2Wab@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/g4JFc5ZwfbFTm9vJl68z/00hF1uR2yv5X2ftSxDD3p/dc7kv
	SsgCjOpDybZz9H6sdgl2zV066dNNMRQxZCcUHZyavHGrClsYRYAnLZDUJy0+sWGZs7CfGGvOFIk
	QXpaHaMhQwdK7GMC8rzJqSY/Wns35eEM=
X-Google-Smtp-Source: AGHT+IGFV7H0vZmfTHlCjVXHIE89/4Mcx6O+z7ESZW4fW4/yihBmQaueis7nCeFt/e7kQ5H3nmZF0lvWWxyQZbHGKCM=
X-Received: by 2002:a05:6512:32c6:b0:553:268e:5018 with SMTP id
 2adb3069b0e04-558fa8ffd2amr626136e87.31.1752057191347; Wed, 09 Jul 2025
 03:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com> <og5rlraf4zar6s3pvtcxpsvqomcrkzt3gxeojwnfljvpweobn5@6ee3wmdl6egn>
In-Reply-To: <og5rlraf4zar6s3pvtcxpsvqomcrkzt3gxeojwnfljvpweobn5@6ee3wmdl6egn>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Jul 2025 20:32:58 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGVm7uK6=YBDkcxLNsw7iLORREx5EZL-5aErS7zx71Y+g@mail.gmail.com>
X-Gm-Features: Ac12FXxiax-fZOuJX1m2y722TrJg87LCBfQLSuoZh24t41CZ8TwH5qOaaPW3LKE
Message-ID: <CAMj1kXGVm7uK6=YBDkcxLNsw7iLORREx5EZL-5aErS7zx71Y+g@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] x86: strict separation of startup code
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 20:23, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Jul 09, 2025 at 10:08:41AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > !!! Boot tested on non-SEV guest ONLY !!!!
>
> TDX guest boots fine.
>

Thanks!

