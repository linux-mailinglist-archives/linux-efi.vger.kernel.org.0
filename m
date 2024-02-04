Return-Path: <linux-efi+bounces-469-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7718490F3
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 23:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD31B20DBF
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6B33998;
	Sun,  4 Feb 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+sW2MRw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D733995;
	Sun,  4 Feb 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084210; cv=none; b=LdqqOTAfoTreNBUpBT71bq0RfzG8teL9m+4yWdKcs/+9+LJgZfrxQ3EFdTE5aZ9WH3vY0uIsTeYW44rgIqWKISfvuMFP/8Ty2JcApkWjD7HkLhgfAvGwVvwnf7CP73mxUcG5/JEr2wQkxqmABYFFxPwAkpmmVvaS/ZXBsufakyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084210; c=relaxed/simple;
	bh=O/gpGECUj1fIinpdoqmtbcxTdNsoz84TcgMFZVxJDIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4Fv3fYa14G+HsAg+eLRmtKPkHXunSKg1T1+Vg7qXUjFZUFPwvMXO/KnOSWIMYyzjhektikyS91Fcen3NKCfU9bysejwwgmWOVkjpz9pJlWPXst2ZSAtTdnGihJ3m9EX4mOmAsVaQ6+XaLlD556HbPPQAcZgpG5dnpTSL0mWuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+sW2MRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E63C433C7;
	Sun,  4 Feb 2024 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707084209;
	bh=O/gpGECUj1fIinpdoqmtbcxTdNsoz84TcgMFZVxJDIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+sW2MRwdzdSQWjiIpfpqGzrc5IAomgjpH1Q7XnDs0iqtolzJwyin/DLwTI6NR34o
	 IU1liAb6UPry8crl3lfUhc4sNspuMhbOl/Hbv2jKykd9HVxIn/aZ1OWoD7lv4+r/O7
	 I3Gw5VLpmqyTQz1CIqNjhNNCgUUTpM15OzUrz0wHJIEzYvbDltqy1ZJNVdbrMWYF/g
	 IfdWhyuKL5mtMYMvJSQPeST/sv42OKRFX5KRpKemF2aJUqVRrh/2BC/2TsGPK9M8sI
	 PA83hrfzE03jLTFD4dnmICROlYPz+sWiptYRLyqRFIEkoPdqBZgQ06UZdSUrLRJsOL
	 csHrfunNRKO8A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114fa38434so324149e87.0;
        Sun, 04 Feb 2024 14:03:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwAAm2BowIUYvs8NBnNStXN8dZsu+PFQ2ykL60T/b80zj42dlpJ
	7oO28x7BC40T3rVRHaqzXgsQ/LDtfwE8blHN6bIncOkLlvexMpX9UobcGPIhK/p/pNR4nUzb+K6
	/yB16X0sc5Sr1WrBgVnsUotJdXP4=
X-Google-Smtp-Source: AGHT+IH/FxRcohMCSzZ1ELV9B1/uJ34huOq+CLlHND9mADal8S1sIwFjoQdfeHwCeFsnD3edUIQBkLZBUfPPC+ejCow=
X-Received: by 2002:a05:6512:1112:b0:511:4e2b:671d with SMTP id
 l18-20020a056512111200b005114e2b671dmr1189306lfg.69.1707084207659; Sun, 04
 Feb 2024 14:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com> <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
In-Reply-To: <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 4 Feb 2024 23:03:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF_02CO9C61N4uL6Z03Gtf5VmiqoCbk8beL4vd4PDHc0w@mail.gmail.com>
Message-ID: <CAMj1kXF_02CO9C61N4uL6Z03Gtf5VmiqoCbk8beL4vd4PDHc0w@mail.gmail.com>
Subject: Re: [PATCH v1] efi/libstub: Add Confidential Computing (CC)
 measurement support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, "Yao, Jiewen" <jiewen.yao@intel.com>, 
	"Lu, Ken" <ken.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 21:28, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> +Jiewen & Ken (RTMR firmware owner)
>
> On 2/3/24 10:46 PM, James Bottomley wrote:
> > On Sat, 2024-02-03 at 07:57 +0000, Kuppuswamy Sathyanarayanan wrote:
> >> If the virtual firmware implements TPM support, TCG2 protocol will be
> >> used for kernel measurements and event logging support. But in CC
> >> environment, not all platforms support or enable the TPM feature.
> >> UEFI specification [1] exposes protocol and interfaces used for
> >> kernel measurements in CC platforms without TPM support.
> >>
> >> Currently, the efi-stub only supports the kernel related measurements
> >> for the platform that supports TCG2 protocol. So, extend it add
> >> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event
> >> logging support. Event logging format in the CC environment is the
> >> same as TCG2.
> > Why do we have to do this anymore?  Given that you're already pushing
> > patches that map RTMRs to TPM PCRs:
> >
> > https://lore.kernel.org/lkml/20240128212532.2754325-4-sameo@rivosinc.com/
>
> IMHO, I am not sure whether we need this mapping support . I have already
> mentioned the same comment in [1]. If we support extension and logging
> via configFS ABI, why again support PCR mapping?
>
> https://lore.kernel.org/lkml/2bd7c80b-9cd8-4450-a410-c3739d224167@linux.intel.com/ [1]
>
> >
> > Can't you just add a stub TCG2 driver to EFI that exposes only the
> > ability to log and measure using this mapping?  That way all our
> > existing code will "just work" without the need to understand anything
> > about confidential computing or add new code to do the measurement?
>
> I am not familiar with the EFI implementation, but I think a new protocol
> is added to handle future CC extensions (which could deviate from
> TCG2) and to support platforms that does not support or enable TPM
> feature. So modifying the TCG2 driver in EFI may not work for the
> above-mentioned cases. I think the EFI driver part of this support
> is already merged.
>
> Jiewen/Ken may have more comments about this proposal.
>

I don't think it is sufficient to wire up the CC protocol here. There
is more code in drivers/firmware/efi/libstub/tpm.c that deals with the
event log.

Given that the EFI CC protocol was specifically designed to act as a
substitute for the TCG2 protocol, I would expect all occurrences of
TCG2 protocol invocations to be handled accordingly.

So I think the approach here should be to provide a local wrapper
around get_event_log() and hash_log_extend_event() that is backed by
either the TCG2 protocol of the EFI cc protocol, and all current
callers invoke this wrapper rather than the TCG2 protocol directly.

