Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC19D3F9
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfHZQ2b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 12:28:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:39125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbfHZQ2b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Aug 2019 12:28:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 09:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="185007856"
Received: from clevorn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.202])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2019 09:28:26 -0700
Date:   Mon, 26 Aug 2019 19:28:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
References: <20190826153028.32639-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826153028.32639-1-pjones@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 26, 2019 at 11:30:27AM -0400, Peter Jones wrote:
> Some machines generate a lot of event log entries.  When we're
> iterating over them, the code removes the old mapping and adds a
> new one, so once we cross the page boundary we're unmapping the page
> with the count on it.  Hilarity ensues.
> 
> This patch keeps the info from the header in local variables so we don't
> need to access that page again or keep track of if it's mapped.
> 
> Signed-off-by: Peter Jones <pjones@redhat.com>
> Tested-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
