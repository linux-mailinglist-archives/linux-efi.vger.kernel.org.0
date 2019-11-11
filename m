Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0DF8307
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 23:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKKWhl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 17:37:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKKWhl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Nov 2019 17:37:41 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6858120B7192;
        Mon, 11 Nov 2019 14:37:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6858120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573511860;
        bh=JAJ429uDrlDNbZDkeSdCYcoCvf5POqtncvJncujgjRA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pEqqdmWeWwca6el82Y7BDyoW0kZAMB8in5gjKJPT2x1CG6HOBn/9RiHD4x8RTtit9
         K/rXdmeJTfLfnjR4hDXzrEYWmSGGTUNOl5XZrT/ui95vcOrJQDlI/H1v2sQp5mjse3
         rjQ+HO3OErxJ3Tonv+3R/6GUHlKCF/fQZPMQopUA=
Subject: Re: [PATCH v9 0/4] powerpc: expose secure variables to the kernel and
 userspace
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
        George Wilson <gcwilson@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
References: <1573441836-3632-1-git-send-email-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <216572e5-d8c6-f181-3ec0-b4a840f20f46@linux.microsoft.com>
Date:   Mon, 11 Nov 2019 14:37:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573441836-3632-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/10/19 7:10 PM, Nayna Jain wrote:

Hi Nayna,

> In order to verify the OS kernel on PowerNV systems, secure boot requires
> X.509 certificates trusted by the platform. These are stored in secure
> variables controlled by OPAL, called OPAL secure variables. In order to
> enable users to manage the keys, the secure variables need to be exposed
> to userspace.
Are you planning to split the patches in this patch set into smaller 
chunks so that it is easier to code review and also perhaps make it 
easier when merging the changes?

Just a suggestion - but if, folks familiar with this code base don't 
have any objections, please feel free to ignore my comment.

Patch #1
  1, opal-api.h which adds the #defines  OPAL_SECVAR_ and the API signature.
  2, secvar.h then adds secvar_operations struct
  3, powerpc/kernel for the Interface definitions
  4, powernv/opal-secvar.c for the API implementations
  5, powernv/opal-call.c for the API calls
  6, powernv/opal.c for the secvar init calls.

Patch #2
1, Definitions of attribute functions like backend_show, size_show, etc.
2, secvar_sysfs_load
3, secvar_sysfs_init
4, secvar_sysfs_exit

thanks,
  -lakshmi
