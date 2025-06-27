Return-Path: <linux-efi+bounces-4041-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D2AEB821
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1983B7C2B
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900F2BF00D;
	Fri, 27 Jun 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWJm1SqE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF3BE4A;
	Fri, 27 Jun 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028626; cv=none; b=r1lH0tXTIoln1Cw02yqWRfyKF0FohNwYP12Ldh2B9S0GUXIUsZQHobFV8YTRxir3ZHYqL2vAJbwcXMBaZ9qmf9NF9pNVk30y4hjv4by+74/J/HNbgeiv6N60uCa9kC32SKJ3f9bXCWWjotmC8er6MH71FokWkJeg22QKBCBLzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028626; c=relaxed/simple;
	bh=apcScWYertfmVCc5s0nVnezatVqNPQZKD26Xobpb+uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9EUCWHcRcCedOesDKV+eXky55cob+cZGdi4W6Kq/sHCw5NXdMawR05UGJKqRChEkJt9K/WdfnjiTgb33jz1NckFL+bLmzhwq50J8vbka/z7JVkKfYKcj6+7TCi19s2QJl7Grd/hzryYxo9Qt0wDEq+e5KlAtROpW1gwkxLkGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWJm1SqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C78CC4CEE3;
	Fri, 27 Jun 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028625;
	bh=apcScWYertfmVCc5s0nVnezatVqNPQZKD26Xobpb+uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWJm1SqETG/HN3wItNy/D0gKz9Nr9hMyfHi0n7kpgWMpOk8ikhBNBt50s2ubCA+AA
	 jxqqZ8P8k0K1td9tmsAB9A/7fX+ZycBSYTgIXjwTAW/Lrpl5oQxvToL8vjuOpWSc+U
	 2pVifHdTiWqUiTB2lXSlktwdRkg4VkxCn7BrlUQQZOGXPFYJAPMXOD0ar5C/eOI/YG
	 K9iMAvBSF6ZA3zZMAfJSdCjbcEo7HVJMC0aZuNp7//JC++xlzasP6FmPI7e8hJ6ucQ
	 uDtHSkbnvFy77bj5bAgBSW3UvQKJzgt5ph5DCBpCjnGxUunkT29XmwRRpodZoqfwN0
	 BYiP1CcN+V5hg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV8XC-000000004yD-1W3O;
	Fri, 27 Jun 2025 14:50:26 +0200
Date: Fri, 27 Jun 2025 14:50:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
Message-ID: <aF6Tkh75LRym8MQY@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
 <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
 <aF6NUeNLPrR5vqEf@hovoldconsulting.com>
 <f55a057d-2cdd-411e-97b9-5ede1300a4e9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55a057d-2cdd-411e-97b9-5ede1300a4e9@oss.qualcomm.com>

On Fri, Jun 27, 2025 at 02:26:41PM +0200, Konrad Dybcio wrote:
> On 6/27/25 2:23 PM, Johan Hovold wrote:
> > On Fri, Jun 27, 2025 at 01:54:37AM +0200, Konrad Dybcio wrote:
> >> On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> >>> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:

> >>>> As reported by Johan, this platform also doesn't currently support
> >>>> updating of the UEFI variables. In preparation to reworking match list
> >>>> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> >>>> variables.

> >>>> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> >>>
> >>> R/W works for me (tm).. the META version may be (inconclusive) 2605
> >>
> >> Looked at the wrong SoC META table.. the build date is 05/25/2023
> > 
> > Could be that my machine was not provisioned properly. Do you boot from
> > UFS or NVMe?
> > 
> > My fw is also older: 01/10/2022.
> 
> The machine has UFS, NVME and SPINOR, however the boot log definitely says:
> 
> S - Boot Interface: SPI

Mine says:

S - Boot Interface: UFS

Johan

