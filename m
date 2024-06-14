Return-Path: <linux-efi+bounces-1221-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F312D9092E7
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2024 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86205B24B59
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2024 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93A1487C7;
	Fri, 14 Jun 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVRnls3K"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740417C72
	for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393063; cv=none; b=deP28pOghyE5BfbGpMbaIFBm6R62F4wIBiH4qqh2Cp0YhbEyFYhqukOKaPvJpIk3gEliOF6kmN5Gvl5z9lf1epxzP3SrZCgU07O2qMSY7ZhkV/cddwuV6BN55G78cPwKoJ/+Gkf2jIBKSpDlVlswl7qNYhEX/yOg8YlUuaA+l3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393063; c=relaxed/simple;
	bh=vvQfJ0NSVM9pi3xGIvOC2DsluqfWVIZHWZ5rTrZ8/Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2elfcoNQUy78azINj2o9ItMkbT28K8NY6YBSC5Obmq3gZ3XGs7QR+NOIGs3gYYX5/8XUIe86XhdR6bPVL2wqMMPw3aKy0bYgLduc6e2N9SEpWZL0urEDZtJrTUBTxK/cOw98yGDwQe3eIXnvSvhzzpk9nJ47mXxlWqu0sVof2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVRnls3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917EEC2BD10
	for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2024 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718393062;
	bh=vvQfJ0NSVM9pi3xGIvOC2DsluqfWVIZHWZ5rTrZ8/Sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mVRnls3KObyuBGZsI2f8kZRPNc8GY928FRVKsGtNgVCSJuGYeL1ZhsGtxsaZ0RYzd
	 NcRa3lEajC5+mcSx/6Dfv0EALMV0+NCrtyVCtT7MsLyQtyVROEFLLpaLUf5LFAW3C/
	 sJ2pVpAC9PPEq2G0K5PvaV1IcM24tHS3WfWmQBt5Rhgd5ov6Odj8bAVmsBSylwRZZh
	 mw8pFxTZKQ0c00vmU6vR/+u7smSMhWhX0gLKley55PFusSeC90+xFCIjTGkOcRFMQ2
	 yq2t0mCUtpcQSFTy+ivjaSizPLpm8tY+Bza2MNs1B/xiHe9dOpBODUV70BQy6VC4xx
	 xPUMun5l5iUlw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc0a9cea4so2253466e87.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2024 12:24:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZpHY72R07EJ8wk8y8pIrCi3BA1XxCpkiH+HiY7N4bNuP/8vJN
	D8Xa/6TwMAXo85c6tv8lVbQNlZNC0eZpulRstqeSRWWp2clU6OcPqcSuHNRFglfHd+rl/4wdDoo
	Gv33wTsUDmYH7ATnTsy7FHDOfqmM=
X-Google-Smtp-Source: AGHT+IHf0jmHKs8XMOs58bgTcQVWkjocdcOKj8iHTffbYztVbyHOOWmsg8jFjCDHa+HrMcRv9Kp7PFxSl8TPkFA5rLE=
X-Received: by 2002:a05:6512:3046:b0:52c:ad70:6feb with SMTP id
 2adb3069b0e04-52cad706feemr784996e87.20.1718393060891; Fri, 14 Jun 2024
 12:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
 <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
 <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
 <CAAzv753ZHR46sgncZr4p3dXzxQAZpVgLAzGBhJ2nOPNHo1jttA@mail.gmail.com>
 <CAMj1kXFL0F4H=vj9Rf1ZSeo5Smsu-5ZH7ZSEnhfaju9XW=68Pw@mail.gmail.com> <CAAzv753ie4GeNa7VVieq=OEwLhfD1xcNkMtkuw6fwKe9HU7-cw@mail.gmail.com>
In-Reply-To: <CAAzv753ie4GeNa7VVieq=OEwLhfD1xcNkMtkuw6fwKe9HU7-cw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Jun 2024 21:24:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHtrpZHGCVSbQXJ2LerPaO7E65_9TynEnBUT+MWJTRW3g@mail.gmail.com>
Message-ID: <CAMj1kXHtrpZHGCVSbQXJ2LerPaO7E65_9TynEnBUT+MWJTRW3g@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Nicholas Bishop <nicholasbishop@google.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 21:16, Nicholas Bishop <nicholasbishop@google.com> wrote:
>
> > Btw could you elaborate on the failure mode with mixed mode on recent
> > edk2? The current tip of tree works happily for me.
>
> After doing some checking, it looks like it's specifically an issue
> with SMM -- without SMM_REQUIRE it works fine. I think it's the same
> issue you reported here: https://edk2.groups.io/g/devel/message/108937
>

Ah I had forgotten all about that.

I'll take a look next week to see if something can be done about that
- it shouldn't be too hard in principle.

