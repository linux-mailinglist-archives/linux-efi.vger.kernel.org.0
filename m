Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389F7E366D
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503075AbfJXPUS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 11:20:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38894 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502953AbfJXPUS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 11:20:18 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 650BD20106BE;
        Thu, 24 Oct 2019 08:20:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 650BD20106BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571930417;
        bh=fOMyGZiF2U/ZovXZCK4NxXGRhszfJdpIiYVpPS9my4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Aec2M9vnd4bkFq+YJyfVqt/f6e6cTCfnbLFWz6VXmyIfPtpveq4FRmSkcxURnmukq
         yc5P586Y1pzliC68WKrbH+wbgqDa7TwK90cxmoKM7Pcp1YO/7hI0hzZNTw+cVejRq1
         3bYYgWQLDV+AOyZqQHWlEumXZxWRsb4zKUtge8tM=
Subject: Re: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-6-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1ae56786-4d5c-ba8e-e30c-ced1e15ccb9c@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 08:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/19 8:47 PM, Nayna Jain wrote:

Hi Nayna,

> +void process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, enum ima_hooks func,
> +				int pcr)
>   {
>   	int ret = 0;
>   	struct ima_template_entry *entry = NULL;

> +	if (func) {
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> +					&pcr, &template);
> +		if (!(action & IMA_MEASURE))
> +			return;
> +	}

In your change set process_buffer_measurement is called with NONE for 
the parameter func. So ima_get_action (the above if block) will not be 
executed.

Wouldn't it better to update ima_get_action (and related functions) to 
handle the ima policy (func param)?

thanks,
  -lakshmi
