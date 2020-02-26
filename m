Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173141708D4
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBZTVB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 14:21:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgBZTVB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 14:21:01 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 01E7E20B9C02;
        Wed, 26 Feb 2020 11:21:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01E7E20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582744860;
        bh=W5JGlWfBcPkXP7GPkcMwkkT4Bh9pLTkThoAlCVPwyRQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sP90uYz+6s+BSypzgsp9eYDewZcb3nzcjwkoUZPDiJcQlBfut+kdr1zeFmQHWh1/Z
         +9CCAIkM1znTN/EcRfAb2OLHvdncSDza5XnDZ3KvVN53OHh+iPP6ONDSj9fX0B2V4E
         ZdtGrhFm20v1aAMh41WfyHskx9YNOblByQHjRXtQ=
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
Date:   Wed, 26 Feb 2020 11:21:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Nayna,

> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	bool
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY
> +	default n
> +	help
> +	   This option is selected by architectures to enable secure and/or
> +	   trusted boot based on IMA runtime policies.
> 

Why is the default for this new config "n"?
Is there any reason to not turn on this config if both IMA and 
IMA_ARCH_POLICY are set to y?

thanks,
  -lakshmi

