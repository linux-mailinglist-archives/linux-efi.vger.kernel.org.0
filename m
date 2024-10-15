Return-Path: <linux-efi+bounces-1975-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6599F599
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E662821F8
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4ED227B86;
	Tue, 15 Oct 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3zcE+T9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5760227397;
	Tue, 15 Oct 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016954; cv=none; b=NBd+WHAayrL9KXnpDJB+d/zE4js3fpYHTF/x5a+2ioVhgLZIqSJ7aNnsrF+eUMn/Fvkh1kcdouaHJY/uqr5fzSiGtgE7aLHKJ96PdFzddh2I8UFxrelkvHFahkKdGwylVDMJieOR8FtoDDuDg7YIq/Vv6TKNwkdMS0QUCitDWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016954; c=relaxed/simple;
	bh=m6b13lVpucu+ncZUA0xOOWzdAXwwiWt6kGLy0UGwYeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyJPd6ClTflarWkQv/llMN/n0LBbt79jyYscWrPHzYcju6iXq0zqT1ogaFSjUlZYBWlPXSAvThLaQtYsXPMbTjl7wTphaSwd0gnhiiERvPRlXlJGtuoVlMRjRKC0T9dGl8+vgi9Hu7D4a/D6YbxEoga+wqwHhyiAPYhgAF3dWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3zcE+T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2691EC4CEC7;
	Tue, 15 Oct 2024 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729016954;
	bh=m6b13lVpucu+ncZUA0xOOWzdAXwwiWt6kGLy0UGwYeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3zcE+T9d5FBjYIEjMgBl/sFqFN0CAQM10MYrflC4/mzYgQwblGVxozpGlJdPw6Ks
	 rd85t1K+DW564ju5hD5v2Qp0gxCfvBw+6Og2sXlQ+JRMXI5PSko2Fd4P36W3aiCmIN
	 59jO+5s5YSO8nwZBB8fR7TxnkbYsmHUjr/SVBrtQy/wXs/PaGwYrDpz+uEmdk8KVTF
	 tBHf1tWa7wi+EQIheGaTgX42CiFVbwBHIh69UhcMUD94s4cvQRGQT9lHqKjywhkZhD
	 wULLHtK4dXECw+8Y9n1Gx2iQVwv+X57NxwPIPj909yNExEhAkwyphPkz74W/ro5mKQ
	 GamfEloAbu7vw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso3248276e87.2;
        Tue, 15 Oct 2024 11:29:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWud2+YGVtWiXnrDj2DLXAgRm83bZuCM+AorVS+vCC+rjaCB02PpKEU9vexB1CAag6HjADEcKgNlkVtH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cT9WpN7HRiJNrzfY8cSBn9W9HJRNiaRDyKne7jp1bu98DSWq
	XnudIt1g7dLXHJzqJlf/KZdf7JBmSv1S2sin054TKja+B8vdlwjZajacYQlHVEwveq1gYyNeM1g
	gvtIDkVkcIgx9eRazOIHKbqdgtqM=
X-Google-Smtp-Source: AGHT+IFvq6Z3oYwoeIvyDsc2ily/xnp7ZIhTAkohj1VaGoB+j/yXF7++CXmXZzykz9tSxkujf35lVy0R6vZT5sxX1F8=
X-Received: by 2002:a05:6512:2346:b0:539:94aa:d512 with SMTP id
 2adb3069b0e04-539e572830bmr7026468e87.53.1729016952517; Tue, 15 Oct 2024
 11:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913231954.20081-1-gourry@gourry.net>
In-Reply-To: <20240913231954.20081-1-gourry@gourry.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 20:29:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGXwtvNgbR1YdvpbHxcU2Mz=hES+0d7Lrue=5j_+3_NRw@mail.gmail.com>
Message-ID: <CAMj1kXGXwtvNgbR1YdvpbHxcU2Mz=hES+0d7Lrue=5j_+3_NRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] libstub,tpm: fix small bugs and improve error reporting
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 15:26, Gregory Price <gourry@gourry.net> wrote:
>
> The efi/tpm code has a number of small signed/unsigned bugs and
> inaccuracies are prone to cause further bugs in a difficult to
> debug manner.  For example, there is a signed/unsigned mismatch
> in efi/tpm.c that can lead to calling memblock_reserve on a range
> with an effectively negative length.
>
> Additionally, there are silently ignored error conditions may
> result in undefined behavior.  Address these.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
>
> Gregory Price (4):
>   tpm: fix signed/unsigned bug when checking event logs
>   tpm: do not ignore memblock_reserve return value
>   tpm: fix unsigned/signed mismatch errors related to
>     __calc_tpm2_event_size
>   libstub,tpm: do not ignore failure case when reading final event log
>

Now queued up - thanks.

>  drivers/firmware/efi/libstub/tpm.c |  9 ++++++---
>  drivers/firmware/efi/tpm.c         | 26 ++++++++++++++++----------
>  include/linux/tpm_eventlog.h       |  2 +-
>  3 files changed, 23 insertions(+), 14 deletions(-)
>
> --
> 2.43.0
>

