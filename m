Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA938E644
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhEXMJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 08:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232684AbhEXMJs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 May 2021 08:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621858100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SG5PHcm3N2r6OH4+o6Ayr7esIOujvwtFU8EaysbDMm0=;
        b=R93jfKsmfLVXzUzS1rEMg4fsyypk/ULsFtZKs8f59KMB2kqssjDgnVRiHTgGJ/dPVmLkhF
        kip0NiXzudT4fzAV8gLMfQYE0akIYhgCq0wDGHfByaBZ1Jl9q2p7rHDB5roDuLI8c6rVDv
        3jEWi/xbyPJvK9xJm5ZHenlrNGGWAlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-Tb0XBAKPO4O5YKt-JoO5Gg-1; Mon, 24 May 2021 08:08:16 -0400
X-MC-Unique: Tb0XBAKPO4O5YKt-JoO5Gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC473107ACF8;
        Mon, 24 May 2021 12:08:09 +0000 (UTC)
Received: from work-vm (ovpn-112-207.ams2.redhat.com [10.36.112.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42607100EBAF;
        Mon, 24 May 2021 12:08:06 +0000 (UTC)
Date:   Mon, 24 May 2021 13:08:03 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>, Dov Murik <dovmurik@linux.ibm.com>
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
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
Message-ID: <YKuXI9TUBa3sjY3e@work-vm>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
 <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
 <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
 <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Andi Kleen (ak@linux.intel.com) wrote:
> 
> > The SEV-SNP attestation approach is very similar to what Andi described
> > for the TDX. However, in the case of legacy SEV and ES, the attestation
> > verification is performed before the guest is booted. In this case, the
> > hyervisor puts the secret provided by the guest owner (after the
> > attestation) at a fixed location. Dov's driver is simply reading that
> > fixed location and making it available through the simple text file.
> 
> That's the same as our SVKL model.
> 
> The (not yet posted) driver is here:
> 
> https://github.com/intel/tdx/commit/62c2d9fae275d5bf50f869e8cfb71d2ca1f71363
> 

Is there any way we could merge these two so that the TDX/SVKL would
look similar to SEV/ES to userspace?  If we needed some initrd glue here
for luks it would be great if we could have one piece of glue.
[I'm not sure if the numbering/naming of the secrets, and their format
are defined in the same way]

> We opted to use ioctls, with the idea that it should be just read and
> cleared once to not let the secret lying around. Typically you would just
> use it to set up dmcrypt or similar once. I think read-and-clear with
> explicit operations is a better model than some virtual file because of the
> security properties.

Do you think the ioctl is preferable to read+ftruncate/unlink ?
And if it was an ioctl, again could we get some standardisation here -
i.e.
maybe a /dev/confguest with a CONF_COMP_GET_KEY etc ?

Dave

> -Andi
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

