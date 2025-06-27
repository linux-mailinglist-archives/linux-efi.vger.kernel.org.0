Return-Path: <linux-efi+bounces-4039-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523CAEB7A8
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC97F189147E
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314B2BEC3D;
	Fri, 27 Jun 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1bxSfWL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212117C21C;
	Fri, 27 Jun 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027266; cv=none; b=oejWYIaCQmUlCwagb26AiQbJ/kYn+JpJO0aARFKdu/6cLPsR3aTZMTDYS231ORKgYco3l2hWTDlQDNJrL6aj/cQ4g1pgrws270+vkKGCvyDsgDMzMwj3K7DBFhm+sLYlF/lpW0ChKPJWU0nf8WDPBscN6qNnVNk6htsNoQk7kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027266; c=relaxed/simple;
	bh=ko46wf74UPuaBf8qnx6d5+XlMWO0mj08q8KVAwi9ZFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez5kOjuLFe1GBEsI8T+RLTBcV3zOy1f3dAsUzm3rrza5pdV/GDakOT8v4fojpjr8gkWKZxLRg1YgpWG957tPeocBtz1mTp4SbH9takN3N39JWryCAlmgmdGoTZ8RVve1OO8KTWh6+BsULnSZFjKja2SI1oxmX4zeGaD+Dcc7SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1bxSfWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43684C4CEF0;
	Fri, 27 Jun 2025 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751027266;
	bh=ko46wf74UPuaBf8qnx6d5+XlMWO0mj08q8KVAwi9ZFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1bxSfWL4g6xsJkilr3TAIfqSUt/R2hOXsMVfmDMZLJ98xgpU0Lp8xnXgpmIQf7ef
	 O4roDp19sddFW3lpHahY1Ns4binuzsEczk4seEwR/bRad+6Cs7t8nFI8xBTbCCRS3D
	 7HHAGBMrRyd6YMr6VbYBPa7GPWMBS3OGpHopeFKGXoCReqIBCmevpASFr4n4MxXrD6
	 VBBwog7JKqzdg5hLLIosguSgpoWMqMgUpt0a5qmHJkconL/hC+U108leCgfvYDH+tn
	 CixlwGK0bopQzkPhoI8s0a6jF+ne9mgOc7xPMx5z+PAwW59G0ReoiRBjQ36MpWv75Y
	 Yj/iLtLWAPWOg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV8BG-000000004eC-3OB0;
	Fri, 27 Jun 2025 14:27:46 +0200
Date: Fri, 27 Jun 2025 14:27:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/8] efi: efivars: don't crash in
 efivar_set_variable{,_locked} in r/o case
Message-ID: <aF6OQqD9V7AYUkwO@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com>
 <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
 <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
 <CAO9ioeWwyxSgG9DNYpW-Z_SU_Scv+4sSBs8UeZnxFz+tOaESEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9ioeWwyxSgG9DNYpW-Z_SU_Scv+4sSBs8UeZnxFz+tOaESEQ@mail.gmail.com>

On Thu, Jun 26, 2025 at 03:54:11PM +0300, Dmitry Baryshkov wrote:
> On Thu, 26 Jun 2025 at 15:51, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jun 26, 2025 at 02:03:44PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jun 26, 2025 at 12:04:30PM +0200, Johan Hovold wrote:
> > > > On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> > > > > If efivar implementation doesn't provide write support, then calling
> > > > > efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> > > > > RTC offset) will crash the system. Prevent that by checking that
> > > > > set_variable callback is actually provided and fail with an
> > > > > EFI_WRITE_PROTECTED if it is not.
> > > > >
> > > > > Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> > > >
> > > > I don't think a fixes tag is warranted here as it currently appears to
> > > > be expected that the callers check if setvar is supported before calling
> > > > this helper (e.g. by calling efivar_supports_writes() as efivarfs does).
> > >
> > > It is not documented as such. So, I think, we'd better not crash the
> > > callers.
> >
> > You need to look at the backstory to determine that before jumping to
> > conclusions (e.g. start by looking at f88814cc2578 ("efi/efivars: Expose
> > RT service availability via efivars abstraction")).
> 
> _documented_. I'll update documentation for efivar_set_variable() in
> the next iteration and add a check to the RTC driver. However I still
> think that this patch is valid.

Still depends on *how* we want to address this.

> > > > So should perhaps be fixed in the RTC driver if we agree that supporting
> > > > read-only offsets is indeed something we want.
> > > >
> > > > Are there any other current user that may possibly benefit from
> > > > something like this?
> > >
> > > efi-pstore comes to my mind.
> >
> > No, that driver is also disabled when efivar_supports_writes() returns
> > false.
> 
> Good.

Ok, so then there are no current drivers that will benefit from your
change, but you may (or may not) need it if you enable RO efivars on
this particular platform. That is, this patch is not actually fixing
anything that is broken currently.

Johan

