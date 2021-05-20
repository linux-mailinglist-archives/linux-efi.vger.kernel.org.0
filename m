Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9D38B955
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhETWDl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 May 2021 18:03:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:49120 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhETWDl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 May 2021 18:03:41 -0400
IronPort-SDR: IT1Xd+0wLmDiJN0IZHTaiMHIXvdkCbAOaS5qxOQRFeycmQo/lkyPQnECxzQwaxScQKxmKxPmYr
 Qrn3NcEhkJbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="180954367"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="180954367"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:02:19 -0700
IronPort-SDR: +aAe5WlQDqLOR+GbbEmM2f9botOQNm+eucww5GgQWidItvwmCQjLNIrVjc/06ldIyE8zSop1DT
 A4iVLvNkMByA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475410755"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.197.177]) ([10.212.197.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:02:17 -0700
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
Date:   Thu, 20 May 2021 15:02:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKZAUdbikp2Pt0XV@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 5/20/2021 3:56 AM, Dr. David Alan Gilbert wrote:
> * Brijes
> The nice thing about Dov's device/file is that it's a simple text file
> that userspace can then read the secret out of;  I'm not sure if there's
> anything similar in SNP (or for that matter TDX, cc'ing in Andi)

In TDX there are two different mechanisms:

- One is a ACPI table (SVKL) that allows to pass small pieces of data 
like keys from the BIOS. We have a little driver to read and clear the 
SVKL data. This would only be used if the TD BIOS does the negotiation 
for the secrets, which it doesn't do currently.

- In the other model the negotiation is done by a user program, just 
using another driver to issue calls to the TDX module. The calls just 
expose the TDREPORT, which encodes the attestation data, but does not 
actually include any secret. Then the negotiation for the secrets is 
done by the program, which can then pass it out to other programs (like 
mount for encrypted file systems). In such a case the secret is never 
touched by the kernel. At least initially we'll use the second option.

-Andi

57ccc1
