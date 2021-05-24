Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50F38F19C
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEXQdF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 12:33:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:56102 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhEXQdE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 May 2021 12:33:04 -0400
IronPort-SDR: 0FR48arFwoLIkTSV53z6WrU0eXyMv78fgy7BemWHjvRpMnl9WHikyTVh0Hc+VU/gVXyMXxCQdE
 bEetJFxGxYvg==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="181611693"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="181611693"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 09:31:31 -0700
IronPort-SDR: GH/5PujyThDo8fAsIM0BcShiq41mle/k5/Vpn6FzkVejE3D0EYzcZMaoUUhNMqykOKWbC5XvAJ
 4stBkVRS8Osw==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="435338314"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 09:31:30 -0700
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, linux-efi@vger.kernel.org,
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
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
 <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
 <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
 <YKuXI9TUBa3sjY3e@work-vm>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <81aa5e70-ab94-393c-92e1-fdac14708aff@linux.intel.com>
Date:   Mon, 24 May 2021 09:31:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKuXI9TUBa3sjY3e@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 5/24/2021 5:08 AM, Dr. David Alan Gilbert wrote:
> * Andi K
> Is there any way we could merge these two so that the TDX/SVKL would
> look similar to SEV/ES to userspace?  If we needed some initrd glue here
> for luks it would be great if we could have one piece of glue.
> [I'm not sure if the numbering/naming of the secrets, and their format
> are defined in the same way]
Maybe. There might well be differences in the contents as you say. So 
far SVKL doesn't really exist yet,  initially there will be the initrd 
based agents. The agents definitely will need to know about TDX.
>
> Do you think the ioctl is preferable to read+ftruncate/unlink ?
> And if it was an ioctl, again could we get some standardisation here -
> i.e.
> maybe a /dev/confguest with a CONF_COMP_GET_KEY etc ?

The advantage of the two ioctls is that they are very simple. Anything 
with a file system would be a lot more complicated. For security related 
code simplicity is a virtue.

Also since it's a really simple read and clear model I don't expect the 
value to be used widely, since it will be gone after boot anyways.

-andi



