Return-Path: <linux-efi+bounces-4392-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147AB07D71
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 21:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15578188042B
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B6293C78;
	Wed, 16 Jul 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaK//GpY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74502857F1;
	Wed, 16 Jul 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693240; cv=none; b=awN077/jJx/67h1OHGM/oU8rf1LqFa3JJePI1qhw4L9d387i2JBVAzgtn4CyIu5p8a8E2Hh7aEI/I0pZyCO+wY7cvwYpwucUNSyRNJdYWxmImyWSmwfpodtenxM33ug9SlH5UCIU+dEW1oYEUi5QCWe2GW+9ALr76FSTgFKgA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693240; c=relaxed/simple;
	bh=wMvFp6GOYtxclHUPXXmW70DIVosqnttvEsdsOIRX/OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjHc+OlteY5VQc8rJsSNfgzi1IrlG/IurJLR8HuBkKrsKo8z/pQiuoUCw/Y6P7M93aobhtourkz/Yx5e3G2RAUsEutHmmBfHLrxBnVhoD4EJjd65XbhBXQLP7Rq4LFjvUr5R1lUHTI/Scr18tASo06ynMvcq8U/sjQXbcklzj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaK//GpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC8DC4CEF1;
	Wed, 16 Jul 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752693240;
	bh=wMvFp6GOYtxclHUPXXmW70DIVosqnttvEsdsOIRX/OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaK//GpYbf8paUO8pDsg5F3EeI4cxIsKn27d2eNH+Ae1UKgTLoa94Q1ii5pGBZbU3
	 DB5WYb7avVFyN+wnCmy8kPPPZwDvJ3eZRop87y35B0uTEKd17BvKoVioMj1zXL5JkI
	 1srMByZjT3qZnRWSloY/IQNMuyOl3oZ8URe+rwQHkTYwxzmp8ncQYEL4zV38JCeS3J
	 oZn4x4xfpA744kNNHMSuY2Lkcsc6q0axygPN+fJ0+ERd8peQokZ79e1YYV8IBDMRjJ
	 Zq+CXC+3ovNdJeVtV6l03/TnMkmfl+P8lZT/9VuaM9X8ROqRt16zR+wZUOTG/yJkmT
	 zg9xAvDUPbwrw==
Date: Wed, 16 Jul 2025 14:13:57 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/8] firmware: qcom: uefisecapp: add support for R/O
 UEFI vars
Message-ID: <4ylx7fxgwozm4yaavltlq6disd54acm3iko6tte2rxhufgq6rj@scwldtfbelg6>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-3-aacca9306cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-more-qseecom-v4-3-aacca9306cee@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 01:53:22AM +0300, Dmitry Baryshkov wrote:
> For some platforms (e.g. Lenovo Yoga C630) we don't yet know a way to
> update variables in the permanent storage. However being able to read
> the vars is still useful as it allows us to get e.g. RTC offset.
> 
> Add a quirk for QSEECOM specifying that UEFI variables for this platform
> should be registered in read-only mode.
> 

In order to implement UEFI variable storage on any device where the OS
owns the one storage device requires some form of bridge service running
in the OS.

We should expect that such devices will exist in the future as well (due
to BOM cost) and as such a solution for this will have to present itself
in a upstream compliant fashion.

There's a lot of infrastructure being introduced here to convey a single
boolean flag which I'm hoping to be dead code sooner rather than later.



Now there's some differences in your wording between the patches and the
responses. In some places you're talking about the C630 crashing, in
others you describe it as EFI variable writes aren't persistent. That
makes me wonder if we have two problems, or what you're refering to here
is just the same problem we see on all UFS-based systems (Qualcomm and
others).

Regards,
Bjorn

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 18 +++++++++++++++++-
>  include/linux/firmware/qcom/qcom_qseecom.h      |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> index 98a463e9774bf04f2deb0f7fa1318bd0d2edfa49..05f700dcb8cf3189f640237ff0e045564abb8264 100644
> --- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> +++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> @@ -792,6 +792,12 @@ static efi_status_t qcuefi_query_variable_info(u32 attr, u64 *storage_space, u64
>  	return status;
>  }
>  
> +static const struct efivar_operations qcom_efivars_ro_ops = {
> +	.get_variable = qcuefi_get_variable,
> +	.get_next_variable = qcuefi_get_next_variable,
> +	.query_variable_info = qcuefi_query_variable_info,
> +};
> +
>  static const struct efivar_operations qcom_efivar_ops = {
>  	.get_variable = qcuefi_get_variable,
>  	.set_variable = qcuefi_set_variable,
> @@ -804,7 +810,9 @@ static const struct efivar_operations qcom_efivar_ops = {
>  static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>  				 const struct auxiliary_device_id *aux_dev_id)
>  {
> +	unsigned long *quirks = aux_dev->dev.platform_data;
>  	struct qcom_tzmem_pool_config pool_config;
> +	const struct efivar_operations *ops;
>  	struct qcuefi_client *qcuefi;
>  	int status;
>  
> @@ -829,7 +837,15 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>  	if (status)
>  		return status;
>  
> -	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
> +	if (quirks &&
> +	    *quirks & QCOM_QSEECOM_QUIRK_RO_UEFIVARS) {
> +		dev_dbg(&aux_dev->dev, "R/O UEFI vars implementation\n");
> +		ops = &qcom_efivars_ro_ops;
> +	} else {
> +		ops = &qcom_efivar_ops;
> +	}
> +
> +	status = efivars_register(&qcuefi->efivars, ops);
>  	if (status)
>  		qcuefi_set_reference(NULL);
>  
> diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
> index 3387897bf36843cccd0bd933dd562390bf674b14..8d6d660e854fdb0fabbef10ab5ee6ff23ad79826 100644
> --- a/include/linux/firmware/qcom/qcom_qseecom.h
> +++ b/include/linux/firmware/qcom/qcom_qseecom.h
> @@ -51,4 +51,6 @@ static inline int qcom_qseecom_app_send(struct qseecom_client *client,
>  	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
>  }
>  
> +#define QCOM_QSEECOM_QUIRK_RO_UEFIVARS		BIT(0)
> +
>  #endif /* __QCOM_QSEECOM_H */
> 
> -- 
> 2.39.5
> 

