Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2328BF0CF0
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 04:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfKFDWA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 22:22:00 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46526 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfKFDWA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Nov 2019 22:22:00 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 188C720B7192;
        Tue,  5 Nov 2019 19:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 188C720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573010519;
        bh=btanoP8xvS9QFvuryL6LOBj/cR6eFnV38JO12TA+2Es=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h8vE0YBTBFtolSdZJ6D5H4kGsI8Fe1ayeWlTmxyy2LPG/uxRdVa6pe1IYU77Gz2sB
         MpYk0o1suZiadsaEDpVL2zwUf9LYYj5U9LsVUfyVmaJZR/iA5V9qV7g6pNWaeE+u31
         Kxd8IkbeVsmeuXj0v3befYTEYuI4h0vOTVs25gNc=
Subject: Re: [PATCH v6 2/4] powerpc: expose secure variables to userspace via
 sysfs
To:     Eric Richter <erichte@linux.ibm.com>, linuxppc-dev@ozlabs.org,
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
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20191105082450.14746-1-erichte@linux.ibm.com>
 <20191105082450.14746-3-erichte@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <79a6a7de-360c-c5c9-04e9-807952098ae5@linux.microsoft.com>
Date:   Tue, 5 Nov 2019 19:22:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191105082450.14746-3-erichte@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/5/2019 12:24 AM, Eric Richter wrote:

> From: Nayna Jain <nayna@linux.ibm.com>
> 
> PowerNV secure variables, which store the keys used for OS kernel
> verification, are managed by the firmware. These secure variables need to
> be accessed by the userspace for addition/deletion of the certificates.
> 
> This patch adds the sysfs interface to expose secure variables for PowerNV
> secureboot. The users shall use this interface for manipulating
> the keys stored in the secure variables.

Can this patch be split into smaller set of changes:
1, Definitions of attribute functions like backend_show, size_show, etc.
2, secvar_sysfs_load
3, secvar_sysfs_init
4, secvar_sysfs_exit

> +static int secvar_sysfs_load(void)
> +{
> +	char *name;
> +	uint64_t namesize = 0;
> +	struct kobject *kobj;
> +	int rc;
> +
> +	name = kzalloc(NAME_MAX_SIZE, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	do {
> +		rc = secvar_ops->get_next(name, &namesize, NAME_MAX_SIZE);
> +		if (rc) {
> +			if (rc != -ENOENT)
> +				pr_err("error getting secvar from firmware %d\n",
> +					rc);
> +			break;
> +		}
> +
> +		kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
> +		if (!kobj) {
> +			rc = -ENOMEM;
> +			break;
> +		}
> +
> +		kobject_init(kobj, &secvar_ktype);
> +
> +		rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
> +		if (rc) {
> +			pr_warn("kobject_add error %d for attribute: %s\n", rc,
> +				name);
> +			kobject_put(kobj);
> +			kobj = NULL;
> +		}
> +
> +		if (kobj)
> +			kobject_uevent(kobj, KOBJ_ADD);

kobject_event() will add kobj and free the memory when done using the 
object?

  -lakshmi
