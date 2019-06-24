Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2157451878
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2019 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFXQXe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jun 2019 12:23:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:5036 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfFXQXe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Jun 2019 12:23:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 09:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="182666147"
Received: from akolosov-mobl1.ger.corp.intel.com ([10.249.33.80])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2019 09:23:31 -0700
Message-ID: <8acf82b7066f260332f9353682d4b83e44b68b88.camel@linux.intel.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Jun 2019 19:23:30 +0300
In-Reply-To: <CACdnJusDaGkTAEWJ41+dGQxRWqxbgk8a_iNq5pCuGp=NsdEXgg@mail.gmail.com>
References: <20190615040210.GA9112@hari-Inspiron-1545>
         <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
         <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com>
         <20190620213722.GA17841@linux.intel.com>
         <CACdnJusDaGkTAEWJ41+dGQxRWqxbgk8a_iNq5pCuGp=NsdEXgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-06-20 at 15:00 -0700, Matthew Garrett wrote:
> On Thu, Jun 20, 2019 at 2:37 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Right! OK, I squashed just the fix to the earlier patch. Master and
> > next are updated. Can you take a peek of [1] and see if it looks
> > legit given all the fuzz around these changes? Then I'm confident
> > enough to do the 5.3 PR.
> 
> All looks good to me. Thanks!

Thank you! I'll send the PR now.

/Jarkko

