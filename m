Return-Path: <linux-efi+bounces-4004-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B78AE9B00
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2245C1C40BB5
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6B221280;
	Thu, 26 Jun 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmMshJW6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E816A94A;
	Thu, 26 Jun 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933010; cv=none; b=fs84VQBEldkhJGYSu8w3zP63EJ0gB8Lm66y2JQKX83Nw0LP4By+XKLkrB2FqnE4BCLT2B3QKNOVaSPTUDAGm2CA0FFv/Oq4x8IUQFpPhUqtIOYIxaA7AfW0yGpz5Eee/auPcu/qU8PUmO7xvFFXl1Url9tqQnt0P20qBVS6pJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933010; c=relaxed/simple;
	bh=OpOexVIoWeOaOQVGzKeCOPdi+3f3efCE5l4uE6zID9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP3wR/wN11ZZ3/toOoA7NCSjWf+jLA8ixBjFmpomuPMfT5he8tf6hJ5juRAbLgMIZNyNBoNHyGpQfvroonGisSdLfgr/5sDZ30I4VX28hv01b/Eu8jDIPr8Pgi3C3MPxdJZE1JwNamunqSmTvHPJmew4gXy/dBK9NobaqRYLFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmMshJW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84008C4CEEB;
	Thu, 26 Jun 2025 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933009;
	bh=OpOexVIoWeOaOQVGzKeCOPdi+3f3efCE5l4uE6zID9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmMshJW6Oc/cM+DWOSQ+dxA0tH0Mr+fpW7IuBKOHDg/XSJ1aKjIJm0EypuQIuqBn5
	 qotLhvOrP/pZQckyUtrhyCsFEfK5TP5tZTqheoDsBhDy8KwNiSpNFuPSj9Gdw+f4Pw
	 PqyNQOpLoGVuGCxXt/vFMN9FyM+LBU5tzPfVfkLo1dx/9eY5HPEeyJ4tsjxLB21L6G
	 FtpW5RY+GHS4NPwqEbUlxYRoASSJXER7yRoZQBNP1O0/agS1S/yAu7Cbkpz4VTULKO
	 g2OffgJ5wjiz9/jY7Yxeb90ZEbg9U9Y7JCmRCWJB7u3aJECq03qfMs72XzAqFSdowB
	 hm8wYTseulsBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUjez-000000007pc-27cI;
	Thu, 26 Jun 2025 12:16:49 +0200
Date: Thu, 26 Jun 2025 12:16:49 +0200
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
	linux-efi@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: qcom: sdm850-lenovo-yoga-c630: fix
 RTC offset info
Message-ID: <aF0eEWK8d-l1Mxma@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-8-aacca9306cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-more-qseecom-v4-8-aacca9306cee@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 01:53:27AM +0300, Dmitry Baryshkov wrote:
> Lenovo Yoga C630 as most of the other WoA devices stores RTC offset in
> the UEFI variable. Add corresponding property to the RTC device in order
> to make RTC driver wait for UEFI variables to become available and then
> read offset value from the corresponding variable.

This is not a fix so please drop that word from Subject.

I'd also expect you to mention that the RTC would be heavily crippled on
this machine as the efi variables cannot be updated.

Is there even a UEFI setup setting for this so that users that have
blown away Windows can ever set the time (which may become totally off
due to drift)?

I'm still not convinced that this is something we want, especially since
you could have a fully functional RTC by providing an SDAM offset
instead like we do on the sc8280xp CRD.

Johan

