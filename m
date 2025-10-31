Return-Path: <linux-efi+bounces-5275-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA263C233CE
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 05:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A250B4E2AC1
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 04:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A326FA52;
	Fri, 31 Oct 2025 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="blwXw/iq"
X-Original-To: linux-efi@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC922B5AD;
	Fri, 31 Oct 2025 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883970; cv=none; b=T0/GefZ8h3wl6OArW9sI3FXQVzhrmo/sLW/S4pzeKUyrZ0uhhPlvzeVEZV5l+b5eBqxg2GGR05eVND6aIuyTIaLj6U+xrmjGypnoe3FhWlqX2lTbY4TtrReEob64IUpu6SsAZ9ydzuUmb1+nakOpgah8JjhEgH9BuBNPmyr0MpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883970; c=relaxed/simple;
	bh=Mzlx1Jki3My90PskIq5MtUmOdsEdvQ1YbxyQk8t4p7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqoJWzP/2wt0icwYoGRqz/4zuyHc1bwK9joFUfLZ0XvJahINfrQVbVrwQMkuMcmyk+ndimQVkI1HZBL2o5KtL486sh8zCk/kvkjoowpGm6dya9S7adsqYJoSki+3jkNRvmKpMbLgVx8MWkGKKskP0yQ/qwqBEXrhSjknVbNW7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=blwXw/iq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7631425CC7;
	Fri, 31 Oct 2025 05:12:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAQWNjLXEiVO; Fri, 31 Oct 2025 05:12:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761883963; bh=Mzlx1Jki3My90PskIq5MtUmOdsEdvQ1YbxyQk8t4p7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blwXw/iqmeep3zsYeN43m2KK2dR4wIw5kQXG/0YO0QKL32l86WcFNcvrENBUHaQwc
	 9jWd1J83d4FE1kTRhKKe12e7ZPnmS6Vf19f7CQGOjoCIYsdEJb8n27+EVshFNFFidu
	 psKZZVlyziI6sSEOMR+q4xuU/I5H/gPZ6WfVN3XiKubD17mzwNbgK+lzozRXdIz2L5
	 In+mzXmtrFOHz9vxBNP6Hrx3KxZkyxY0peXQ6Pz06AZMhjI7W0N5sXLVISXuII/xZo
	 5f+gYo/s5bKYyklK7oKlGuwg5f1hYZ7RXRLs1TaxmIaWnY09+GiQLQ7/qfIUaWGqKq
	 ptarl34+4hRiw==
Date: Fri, 31 Oct 2025 04:12:25 +0000
From: Yao Zi <ziyao@disroot.org>
To: Qiang Ma <maqianga@uniontech.com>, ardb@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message
 print
Message-ID: <aQQ3KUap1cB73HOm@pie>
References: <20251031024328.735161-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031024328.735161-1-maqianga@uniontech.com>

On Fri, Oct 31, 2025 at 10:43:28AM +0800, Qiang Ma wrote:
> In the efi_create_mapping() in arch/riscv/kernel/efi.c,
> the return value is always 0, and this debug message
> is unnecessary. So, remove it.

Should we make efi_create_mapping() return void at the same time, if it
will never fail?

Regards,
Yao Zi

> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

