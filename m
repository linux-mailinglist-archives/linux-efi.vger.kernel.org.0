Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEDE39ED
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfJXR0b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 13:26:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54710 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfJXR0b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 13:26:31 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3B2552007698;
        Thu, 24 Oct 2019 10:26:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B2552007698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571937990;
        bh=5R3b8oxPvTR6qGGx7vVi+OuiVSZNkllUsHU4qd/a/nE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OSCT2WjdmQ1xniyUn2/peoWgE9ycpc8Wc2ZzDicCH9kewV38vZAm5RmcKcKk8JDul
         vNhWVweVtxUsfZF4xhG/qHuI8Rd7EwsQ+Nok8m5DqU4EetWGl4pOiPxKH5SORqCBkb
         rOGzLTADWSqaGBt2UxTEU3rZBd/6AnlKTOr8YOeI=
Subject: Re: [PATCH v9 1/8] powerpc: detect the secure boot mode of the system
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
 <20191024034717.70552-2-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b0282ef2-f75c-a139-9991-01eba15adb22@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 10:26:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/2019 8:47 PM, Nayna Jain wrote:
> This patch defines a function to detect the secure boot state of a
> PowerNV system.

> +bool is_ppc_secureboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
> +	if (!of_device_is_available(node)) {
> +		pr_err("Cannot find secure variable node in device tree; failing to secure state\n");
> +		goto out;

Related to "goto out;" above:

Would of_find_compatible_node return NULL if the given node is not found?

If of_device_is_available returns false (say, because node is NULL or it 
does not find the specified node) would it be correct to call of_node_put?

> +
> +out:
> +	of_node_put(node);

  -lakshmi
