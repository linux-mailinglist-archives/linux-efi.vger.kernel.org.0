Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43C438CB33
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhEUQnI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 12:43:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:30226 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhEUQnI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 May 2021 12:43:08 -0400
IronPort-SDR: EV8RmoBV/vnHBfWhNPkmuQPVdFldDOZ1is4YtPt9I8IyiCsN4xBo8X5AokGx+rGuGfEmgSHwDU
 XVgkp2SqGjZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287063124"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287063124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 09:41:45 -0700
IronPort-SDR: fihFgKgFyU4X7JN8xnsj9NsQA7GNOfUCliJzqMqkTCiJEKn1T1CNCkPxiRzx1azpsblOU88HsC
 /t9X7Ur0n7Pg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544146935"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.65]) ([10.212.131.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 09:41:43 -0700
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     Brijesh Singh <brijesh.singh@amd.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
 <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
Date:   Fri, 21 May 2021 09:41:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> The SEV-SNP attestation approach is very similar to what Andi described
> for the TDX. However, in the case of legacy SEV and ES, the attestation
> verification is performed before the guest is booted. In this case, the
> hyervisor puts the secret provided by the guest owner (after the
> attestation) at a fixed location. Dov's driver is simply reading that
> fixed location and making it available through the simple text file.

That's the same as our SVKL model.

The (not yet posted) driver is here:

https://github.com/intel/tdx/commit/62c2d9fae275d5bf50f869e8cfb71d2ca1f71363

We opted to use ioctls, with the idea that it should be just read and 
cleared once to not let the secret lying around. Typically you would 
just use it to set up dmcrypt or similar once. I think read-and-clear 
with explicit operations is a better model than some virtual file 
because of the security properties.

-Andi


