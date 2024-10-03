Return-Path: <linux-efi+bounces-1896-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A198EBE5
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61FFB242EA
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7C13D897;
	Thu,  3 Oct 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv37J3cu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899513B2B4;
	Thu,  3 Oct 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945478; cv=none; b=NuIXFfUina/YijuLE7LLXwRGg/i3aEvxb5/hrecSvedrtAjmqs4a3p0k/zLRMHKycLZP/2y3fTbfvu2cfVGDqykXraljT87lZ4RegjV0RJdQdIfugQ+1KrFBU7/XTu/QTRIJAp56dtrLEinC6vrVWiT8qW2FW1O9vy0DaG3HPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945478; c=relaxed/simple;
	bh=irdY29ZxX3C0ol6kZFN5OBYzzkXE0T6nix/ajspHcmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuixgTZDnKT27Nb+kHw6neq7cu2+wfcbjDheofgspNsoLDoj1BWDqYx/1S8D1E5NbMJKHTQBv7cjqO12YLJ9Pebx2+tmbTA7KxxohCxxa9oGtBwCBx4FlDxoGszUKd7YjmI218NkyzMsGPHNz9HbZC2t9DX7eEmWmKML7XqZzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv37J3cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B26BC4CEC7;
	Thu,  3 Oct 2024 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727945478;
	bh=irdY29ZxX3C0ol6kZFN5OBYzzkXE0T6nix/ajspHcmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iv37J3cuOlfJdnvegH1u5Uc9Jqqx8Cj6j+Z4BirYgKDxNm6iV5AXpwc7hjhaNxCnX
	 2LSZw9sGbUkq92Gm6+r3v6vLBh85T8vTkkFUJ9BgKBUwVcb5Fkc5ARyTaA/JTSTv81
	 rfcw3Dp1q0v8zgtP77MXWUaGpQafyk8um8gXvK+qfrzssa030wDrbihDXgprOukDLT
	 tCXhZkomXK2IP4DOxVueZc+kgN28eClJSUGHkHXq5JIIlt5hQRlbGgJ6LdJtojn3ur
	 WsqtE0onXaAS1zVqnKQbXKTbBtccEeI9SRPaRTvv5G3IV+VH85/W79YtZl3+JyXnGQ
	 CM1Vsac5RdHvg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so6768151fa.2;
        Thu, 03 Oct 2024 01:51:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJwlrHLqeaic2vvcED3LGxLcc5UuDq0SNQpEjngUplk5CGBEcxWIPDGhjtnBYwlUebr/MQAQBlk77EmD1v@vger.kernel.org, AJvYcCX3PojxwakmkKNSjX4pw9bP640C5oEy71smqkFkzH3ju1F4vPlnWEl/ubDAeOHkXjaUvPIWtMT2tAw=@vger.kernel.org, AJvYcCXlc1Jkbeh/B9bTQvxkD34T8fB/zRxDwdZOdpoLOG3tgChes9p+ljjwdaWez6TowIFKiCpU+yg9UpJe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y85xc/x+Uk7kQu+EziX4qDBIp2mcXcNn2p/Y5kVFHE1nRuVC
	jpLt4QfmCy2r7q1yo9/Z/vzjPUKmVBy0pcNkkSqDFUkHM0O1gPRoypdivaLlbpCwNqLZHyAIavI
	aJAs3RkYcxkJaKPtkQ+YvsrFqebE=
X-Google-Smtp-Source: AGHT+IGS6N/aZ+9oQvOKzRfUU661tHTklmvr0Oi/XSknHoL+TAcnQVlF2xRlf4kh0Ehe89N8yI+Ts+BSSxL3sXxa+bE=
X-Received: by 2002:a05:651c:501:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2fae10a90dcmr38120761fa.28.1727945476668; Thu, 03 Oct 2024
 01:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-2-Smita.KoralahalliChannabasappa@amd.com> <66fdd0f6314c2_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66fdd0f6314c2_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Oct 2024 10:51:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF9BpXXrYJ3doH8CDy4PvgOKUNfpsb84V_mTOFO7QD-9w@mail.gmail.com>
Message-ID: <CAMj1kXF9BpXXrYJ3doH8CDy4PvgOKUNfpsb84V_mTOFO7QD-9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] efi/cper, cxl: Make definitions and structures global
To: Dan Williams <dan.j.williams@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 01:02, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Smita Koralahalli wrote:
> > In preparation to add tracepoint support, move protocol error UUID
> > definition to a common location and make CXL RAS capability struct
> > global for use across different modules.
> >
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> LGTM
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

