Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC99D38A
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfHZP56 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 11:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfHZP56 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Aug 2019 11:57:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C369620828;
        Mon, 26 Aug 2019 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566835077;
        bh=blUYG8ZxI4V85CCdRu6wwyVrWFwoe8m7ktk5ZMl8OdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBnmuK7Pv1FZCHS+Livxfezz4rL3sDkZZ+RwyLnRlwoMa56BTxvqZOBdxs42Yh5op
         S7+MjUjLraULqNWCgT8f0CmoKTO/dSXf0J4YVUptakeIlhn5aaHGbrE7EvuvmMJgGo
         Gm1Oj30vyfO98acaBe7IC1QYe6ai1wJhWrAZVl5A=
Date:   Mon, 26 Aug 2019 17:57:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v3 2/4] powerpc: expose secure variables to userspace via
 sysfs
Message-ID: <20190826155754.GA489@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826145649.GA27342@kroah.com>
 <2c5b8ba3-e5a3-5c80-a291-ea9965db2019@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5b8ba3-e5a3-5c80-a291-ea9965db2019@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 26, 2019 at 11:46:11AM -0400, Nayna wrote:
> 
> 
> On 08/26/2019 10:56 AM, Greg Kroah-Hartman wrote:
> > On Mon, Aug 26, 2019 at 09:23:36AM -0400, Nayna Jain wrote:
> > > +static struct kobj_attribute size_attr = __ATTR_RO(size);
> > Wait, why not just normal ATTR_RO()?
> 
> Oh!! Sorry. I am not seeing this macro in sysfs.h. am I missing something ?

Ugh, no, you are right, I thought it was there as the BIN_ATTR_RO() one
was there :)

> > > +static struct bin_attribute data_attr = __BIN_ATTR_RO(data, VARIABLE_MAX_SIZE);
> > And BIN_ATTR_RO() here?
> 
> This would have worked. I think I just thought to use the same way as
> __ATTR_RO().

Yes, that's fine to use, sorry for the noise.

greg k-h
