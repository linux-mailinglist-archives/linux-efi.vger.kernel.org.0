Return-Path: <linux-efi+bounces-4001-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5EAE9A79
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E43B42CF
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66D2BF009;
	Thu, 26 Jun 2025 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnENumIZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90529C35F;
	Thu, 26 Jun 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931762; cv=none; b=YtDzeVGFKfAbIFdw3Z+4cNN9mO1t7CPy8RIEwPEdtZRmgqCt2CR7Twjx0QzVMEy1DDJBfuwa+ZGZDOZlv3HgQ4myzJJyiNCBsoovFEyZD/zlbDbCSyXB1LSQcUKe0260WchSL5M45fH1EKdRs4gKUhEGvyi0PXVwNoySaY+ys+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931762; c=relaxed/simple;
	bh=NIdi9vkSfJQtqbtgSmTPBIUYBGUucA44r7jAMoBWtrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+lzrRUm/gh4bbyYP9drzsaKM4m95/Z9P2MrLRWF7FL+h/IBUUSdudIL7NePZAGVpjBfBMCiKZcI8di/fX5NolY+1TwkAlfHOS2fbwXW+Yiv2APpj40KeGswCCMFBKOLndp6o/Ht1j055Zah4WqQhBRxI1kQGDPxFvxEIqDG/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnENumIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91818C4CEF1;
	Thu, 26 Jun 2025 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750931761;
	bh=NIdi9vkSfJQtqbtgSmTPBIUYBGUucA44r7jAMoBWtrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnENumIZ1fVJVgXx+uIFkAExIWrr/yFkI5BgCQKsBLrcN0eNG0YjWT+DYcEaq98qa
	 x3AICdrkpFbiul9hG1ulv7WFcbaG7YPqRFhkVVygDubPbLK8ZIJkE0MRP2A+ztSqiC
	 1OkvauffDOxDlz1F0jlM5d8Nsn6d8AXmVUL9Wd5srmTqkJsI9GKJ/SCZWe1fbiYpWw
	 XOxfdxgwQUTg+IsIyE+gmMY+ED/RbUWNmriWmqNm8eQSwzoJPv/hNKWO+7n8aI6NP1
	 HNVeHrfPWl1Wecdj3GCXVtM6QfbkP6IE4tSLWf4nOCnY0aNbLGCWpjZva42jpV+HvE
	 56YSqi4fqJ0+A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUjKr-000000007WP-1woe;
	Thu, 26 Jun 2025 11:56:01 +0200
Date: Thu, 26 Jun 2025 11:56:01 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/8] firmware: qcom: scm: rework QSEECOM allowlist
Message-ID: <aF0ZMcVcgHpqsKoG@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-7-aacca9306cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-more-qseecom-v4-7-aacca9306cee@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 01:53:26AM +0300, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
> Allow it to function as allow and disallow list at the same time by the
> means of the match->data and list the SoC families instead of devices.
> 
> In case a particular device has buggy or incompatible firmware user
> still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
> param and (in the longer term) adding machine-specific entry to the
> qcom_scm_qseecom_allowlist table.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

>  /*
>   * We do not yet support re-entrant calls via the qseecom interface. To prevent
> - * any potential issues with this, only allow validated machines for now. Users
> + * any potential issues with this, only allow validated platforms for now. Users
>   * still can manually enable or disable it via the qcom_scm.qseecom modparam.
> + *
> + * To disable QSEECOM for a particular machine, add compatible entry and set
> + * data to &qcom_qseecom_disable.
>   */
>  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> -	{ .compatible = "asus,vivobook-s15" },
> -	{ .compatible = "asus,zenbook-a14-ux3407qa" },
> -	{ .compatible = "asus,zenbook-a14-ux3407ra" },
> -	{ .compatible = "dell,xps13-9345" },
> -	{ .compatible = "hp,elitebook-ultra-g1q" },
> -	{ .compatible = "hp,omnibook-x14" },
> -	{ .compatible = "huawei,gaokun3" },
> -	{ .compatible = "lenovo,flex-5g" },
> -	{ .compatible = "lenovo,thinkpad-t14s" },
> -	{ .compatible = "lenovo,thinkpad-x13s", },
>  	{ .compatible = "lenovo,yoga-c630", .data = &qcom_qseecom_ro_uefi, },
> -	{ .compatible = "lenovo,yoga-slim7x" },
> -	{ .compatible = "microsoft,arcata", },
> -	{ .compatible = "microsoft,blackrock" },
> -	{ .compatible = "microsoft,romulus13", },
> -	{ .compatible = "microsoft,romulus15", },
> -	{ .compatible = "qcom,sc8180x-primus" },
> +	{ .compatible = "qcom,sc8180x", },
> +	{ .compatible = "qcom,sc8280xp", },
>  	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },

You need to have the machine specific entries before the SoC fallbacks
for this to work.

Perhaps this should be made more clear in the table by adding a
separator comment before the SoC entries or similar.

> -	{ .compatible = "qcom,x1e001de-devkit" },
> -	{ .compatible = "qcom,x1e80100-crd" },
> -	{ .compatible = "qcom,x1e80100-qcp" },
> -	{ .compatible = "qcom,x1p42100-crd" },
> +	{ .compatible = "qcom,sdm845", .data = &qcom_qseecom_disable, },
> +	{ .compatible = "qcom,x1e80100", },
> +	{ .compatible = "qcom,x1p42100", },
>  	{ }
>  };
>  
> @@ -2046,12 +2035,22 @@ static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev,
>  	match = of_match_node(qcom_scm_qseecom_allowlist, np);
>  	of_node_put(np);
>  
> -	if (match && match->data)
> +	if (!match) {
> +		dev_info(scm_dev, "qseecom: untested machine, skipping\n");
> +		return false;
> +	}
> +
> +	if (match->data)
>  		*quirks = *(unsigned long *)(match->data);
>  	else
>  		*quirks = 0;
>  
> -	return match;
> +	if (*quirks & QCOM_QSEECOM_QUIRK_DISABLE) {
> +		dev_info(scm_dev, "qseecom: disabled by the quirk\n");

Not sure this is needed since it presumably has been disabled because it
has been tested and found not to work. No need to spam the logs with
that on every boot.

In any case I don't think you should be referring to "the quirk" which
makes little sense without looking at the implementation.

> +		return false;
> +	}
> +
> +	return true;
>  }

Johan

