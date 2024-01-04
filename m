Return-Path: <linux-efi+bounces-338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C1824B3C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56BC286459
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E602CCBB;
	Thu,  4 Jan 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St9TcoP8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBF2C191;
	Thu,  4 Jan 2024 22:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AAEC433C7;
	Thu,  4 Jan 2024 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704408929;
	bh=rQIZxdKV5Pipm8VxFDLhMTnSoq016JBCEGakE7aq0dE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=St9TcoP8IQofIYdY324GgRjsGC/IbFxNJ7aZvCAM2AtJJbz3wOmVkLPJDvKf1aUX+
	 1vaydmqVnFLsTOxedhzJ89gvxXs6z3F/PjEMzTJ4DFJg3KCdYyEFqJ4OCv7rjGdJnx
	 qhz6Gm0QaoBCu4MTbTApUHWqa/DSuAiFWExOXLbLcgB3u0CGQ8C4edWF/MRqwUe5wt
	 0nIOkZD6KETL1F46POUeyTKfd8XdjXstGc8S7FJSBBK0+fX0SVcPQkLxTv2kQjvDhN
	 su+34Q8EDJzOhYfqHyfw+lUardhm6mJoFXMWe/MStvIlEHqr/3RNGhGG3OS/lq1cnJ
	 rRumZViC6JJWw==
Date: Thu, 4 Jan 2024 16:55:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <20240104225528.GA1830655@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>

On Wed, Dec 20, 2023 at 04:17:27PM -0800, Ira Weiny wrote:
>       cxl/trace: Pass uuid explicitly to event traces

Nit: s/uuid/UUID/ would match the patches below

>       cxl/events: Promote CXL event structures to a core header
>       cxl/events: Create common event UUID defines
>       cxl/events: Remove passing a UUID to known event traces
>       cxl/events: Separate UUID from event structures
>       cxl/events: Create a CXL event union
>       acpi/ghes: Process CXL Component Events
>       PCI: Define scoped based management functions

"scope based" unless I'm misunderstanding something.

Maybe "cleanup and guard functions"?  "management" is pretty generic.

